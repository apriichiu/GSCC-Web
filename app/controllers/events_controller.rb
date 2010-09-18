class EventsController < ApplicationController

  layout "application"
#  before_filter :authorize, :except => [:index, :show]
  before_filter :in_events;

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def in_events
    @in_events = true;
  end
end
