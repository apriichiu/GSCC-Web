require 'logger'

script_dir = File.expand_path(File.dirname(__FILE__))
logfile = script_dir+"/../log/update_facebook.log"
file = File.open(logfile, File::WRONLY | File::APPEND)
logger = Logger.new(file, 'weekly')


t1 = Time.now
logger.info "================"
logger.info Time.now.strftime("%m/%d/%Y-%H:%M:%S") + " : " + __FILE__ + " starting..."
logger.info "================"

logger.info "\ngrabbing file lock....."
if File.new(__FILE__).flock(File::LOCK_EX | File::LOCK_NB) == false
  logger.error "*** can't lock file, another instance of script running?  exiting"
  exit 1
end

logger.info "obtained file lock... starting facebook api calls...\n"
# do the processing...
# ...

##################
# DATABASE ACCESS
##################
logger.info "\nGetting last update time"
#lut - last update time
query = FacebookEvent.find(:first, :order => "updated_time DESC");
if query.nil?
  lutdatabase = Time.at(0);
else
  lutdatabase = query.updated_time;
end
logger.info lutdatabase

##################
# FACEBOOK ACCESS
##################
config = YAML::load(File.open("#{RAILS_ROOT}/config/facebook.yml"));
gscc_app = FbGraph::Application.new(config['production']['app_id']);
access_token = gscc_app.get_access_token(config['production']['client_secret']);
page_id = config['production']['page_id'];

page = FbGraph::Page.new(page_id, :access_token => access_token).fetch;
logger.info "\nAccessing facebook page - "+page.name
#need to fetch event by identifier so you get all the information
logger.info "\nSearching for dirty events..."

page.events.each do |e|
  ie = FbGraph::Event.new(e.identifier, :access_token => access_token).fetch;
  existing_event = FacebookEvent.find(:first, :conditions => [ "identifier = ?", ie.identifier ]);
  if existing_event 
    logger.info "***found database entry "+existing_event.name
    if ie.updated_time > lutdatabase
      logger.info "\n**found dirty facebook event - "+ie.name
      existing_event.name = ie.name
      existing_event.start_time = ie.start_time
      existing_event.end_time = ie.end_time
      existing_event.location = ie.location
      existing_event.description = ie.description
      existing_event.updated_time = ie.updated_time
      existing_event.identifier = ie.identifier
      existing_event.picture = ie.picture
      existing_event.save
      logger.info "***updated "+existing_event.name
    end
  else
    logger.info "***database entry not found, adding to database "+ie.name
    existing_event = FacebookEvent.new( :name => ie.name, :start_time => ie.start_time, :end_time => ie.end_time, :location => ie.location, :description => ie.description, :updated_time => ie.updated_time, :identifier => ie.identifier, :picture => ie.picture )
    existing_event.save
    logger.info "***saved "+existing_event.name
  end
end


##################
# Deleting events 
##################
logger.info "\nLooking for deleted facebook events..."
all_events = FacebookEvent.find(:all);
page.events.each do |e|
  all_events.delete_if { |ae| ae.identifier == e.identifier }
end
if all_events.size > 0
  logger.info "Found deleted events! Deleting events from database..."
  all_events.each do |e|
    logger.info "\n***deleting event "+e.name
    e.delete
    logger.info "****deleted."
  end
end

logger.info "\nUpdate complete."

t2 = Time.now
logger.info Time.now.strftime("%m/%d/%Y-%H:%M:%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
logger.info "================\n\n"

