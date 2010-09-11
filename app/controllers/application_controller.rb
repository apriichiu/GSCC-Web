# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  require "fb_graph"
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  
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
end
