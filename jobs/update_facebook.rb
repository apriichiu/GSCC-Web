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
gscc_page_id = config['production']['gscc_page_id'];
flc_page_id = config['production']['flc_page_id'];

pages = Array.new([gscc_page_id,flc_page_id]);
pages_fetched = []
pages.each do |page_id|
  puts "page_id="+page_id.to_s
  page = FbGraph::Page.new(page_id, :access_token => access_token).fetch;

  pages_fetched.push(page)

  puts "\nAccessing facebook page - "+page.name
  #need to fetch event by identifier so you get all the information
  puts "\nSearching for dirty events..."

  page.events.each do |e|
    ie = FbGraph::Event.new(e.identifier, :access_token => access_token).fetch;
    existing_event = FacebookEvent.find(:first, :conditions => [ "identifier = ?", ie.identifier ]);
    if existing_event 
      puts "***found database entry "+existing_event.name
      if ie.updated_time > lutdatabase
        puts "\n**found dirty facebook event - "+ie.name
        existing_event.name = ie.name
        existing_event.start_time = ie.start_time
        existing_event.end_time = ie.end_time
        existing_event.location = ie.location
        existing_event.description = ie.description
        existing_event.updated_time = ie.updated_time
        existing_event.identifier = ie.identifier
        existing_event.picture = ie.picture
        existing_event.save
        puts "***updated "+existing_event.name
      end
    else
      puts "***database entry not found, adding to database "+ie.name
      existing_event = FacebookEvent.new( :name => ie.name, :start_time => ie.start_time, :end_time => ie.end_time, :location => ie.location, :description => ie.description, :updated_time => ie.updated_time, :identifier => ie.identifier, :picture => ie.picture )
      existing_event.save
      puts "***saved "+existing_event.name
    end
  end
end

##################
# Deleting events 
##################
puts "\nLooking for deleted facebook events..."
all_events = FacebookEvent.find(:all);

all_page_events = pages_fetched.map{|p| p.events}.flatten
all_page_events.each do |e|
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

