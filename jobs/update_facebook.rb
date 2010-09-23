Entry.find(:all).each do |a|
  puts a.title
end

# event = FacebookEvent.new
# event.name = "test event 2"
# event.start_time = Time.new
# event.end_time = Time.new
# event.location = "here"
# event.updated_time = Time.new
# event.identifier = "1231541512"
# event.picture = "http://www.eecs.berkeley.edu/~liuisaac/site/images/me.jpg"
# event.save
## run this with script/runner

t1 = Time.now
puts "================"
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " starting..."

if File.new(__FILE__).flock(File::LOCK_EX | File::LOCK_NB) == false
  puts "*** can't lock file, another instance of script running?  exiting"
  exit 1
end

# do the processing...
# ...

config = YAML::load(File.open("#{RAILS_ROOT}/config/facebook.yml"));
gscc_app = FbGraph::Application.new(config['production']['app_id']);
access_token = gscc_app.get_access_token(config['production']['client_secret']);
page_id = config['production']['page_id'];

page = FbGraph::Page.new(page_id, :access_token => access_token).fetch;
puts "Accessing facebook page - "+page.name
event_gscc = page.events.sort_by{|e| e.start_time};


t2 = Time.now
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
puts "================"

