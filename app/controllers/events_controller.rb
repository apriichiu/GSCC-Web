class EventsController < ApplicationController

  layout "application"
#  before_filter :authorize, :except => [:index, :show]
  before_filter :in_events;

  def index
  end

  def in_events
    @in_events = true;
  end
end
