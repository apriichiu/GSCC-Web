puts "***Updating facebook events***"

t1 = Time.now
puts "================"
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " starting..."

puts "\ngrabbing file lock....."
if File.new(__FILE__).flock(File::LOCK_EX | File::LOCK_NB) == false
  puts "*** can't lock file, another instance of script running?  exiting"
  exit 1
end

puts "obtained file lock... starting facebook api calls...\n"
# do the processing...
# ...

##################
# DATABASE ACCESS
##################
puts "\nGetting last update time"
#lut - last update time
query = FacebookEvent.find(:first, :order => "updated_time DESC");
if query.nil?
  lutdatabase = Time.at(0);
else
  lutdatabase = query.updated_time;
end
puts lutdatabase

##################
# FACEBOOK ACCESS
##################
config = YAML::load(File.open("#{RAILS_ROOT}/config/facebook.yml"));
gscc_app = FbGraph::Application.new(config['production']['app_id']);
access_token = gscc_app.get_access_token(config['production']['client_secret']);
page_id = config['production']['page_id'];

page = FbGraph::Page.new(page_id, :access_token => access_token).fetch;
puts "\nAccessing facebook page - "+page.name
#need to fetch event by identifier so you get all the information
puts "\nSearching for dirty events..."

page.events.each do |e|
  ie = FbGraph::Event.new(e.identifier, :access_token => access_token).fetch;
  if ie.updated_time > lutdatabase
    puts "\n**found dirty facebook event - "+ie.name
    edatabase = FacebookEvent.find(:first, :conditions => [ "identifier = ?", ie.identifier ]);
    if edatabase
      puts "***found database entry, updating the entry "+edatabase.name
      edatabase.name = ie.name
      edatabase.start_time = ie.start_time
      edatabase.end_time = ie.end_time
      edatabase.location = ie.location
      edatabase.description = ie.description
      edatabase.updated_time = ie.updated_time
      edatabase.identifier = ie.identifier
      edatabase.picture = ie.picture
      edatabase.save
      puts "***updated "+edatabase.name
    else
      puts "***database entry not found, adding to database "+ie.name
      edatabase = FacebookEvent.new( :name => ie.name, :start_time => ie.start_time, :end_time => ie.end_time, :location => ie.location, :description => ie.description, :updated_time => ie.updated_time, :identifier => ie.identifier, :picture => ie.picture )
      edatabase.save
      puts "***saved "+edatabase.name
    end
  end
end


##################
# Deleting events 
##################
puts "\nLooking for deleted facebook events..."
all_events = FacebookEvent.find(:all);
page.events.each do |e|
  all_events.delete_if { |ae| ae.identifier == e.identifier }
end
if all_events.size > 0
  puts "Found deleted events! Deleting events from database..."
  all_events.each do |e|
    puts "\n***deleting event "+e.name
    e.delete
    puts "****deleted."
  end
end





puts "\nUpdate complete."

t2 = Time.now
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
puts "================"

