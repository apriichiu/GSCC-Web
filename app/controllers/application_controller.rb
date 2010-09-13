# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  require "vendor/gems/fb_graph-1.0.1/lib/fb_graph"
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :get_facebook_info, :get_events
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def initialize
    super
    @page_title = false
  end

  protected
  def page_title=(new_page_title)
    @page_title = new_page_title
  end

  def page_title
    return @page_title || ((self.controller_name) + '_' + (self.action_name)).humanize
  end

  def page_not_found!
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end
  
  helper_method :render_to_string

  helper_method :admin?

  protected
  def authorize
    unless admin?
      flash[:notice] = "unauthorized access"
      redirect_to events_path
      false
    end
  end

  def admin?
    session[:password] == "7ba44afcb856df9ff8152cff1752a2eb69da845edfa57d328bbb1050f2caee60"
  end

  protected
  def get_facebook_info
    if (!session[:access_token] || !session[:page_id])
      config = YAML::load(File.open("#{RAILS_ROOT}/config/facebook.yml"));
      gscc_app = FbGraph::Application.new(config['production']['app_id']);
      session[:access_token] = gscc_app.get_access_token(config['production']['client_secret']);
      session[:page_id] = config['production']['page_id'];
    end
  end

  protected
  def get_events
    page = FbGraph::Page.new(session[:page_id], :access_token => session[:access_token]).fetch;
    event_gscc = page.events.sort_by{|e| e.start_time};;
    @upcoming_events = event_gscc.find_all{|e| e.start_time >= Time.now};
    @past_events = event_gscc.find_all{|e| e.start_time < Time.now}.reverse;
  end

end
