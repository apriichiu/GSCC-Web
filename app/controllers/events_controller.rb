class EventsController < ApplicationController

  layout "application"
  before_filter :in_events;

  # GET /events
  # GET /events.xml

  def index
  end

  def in_events
    @in_events = true;
  end
end
