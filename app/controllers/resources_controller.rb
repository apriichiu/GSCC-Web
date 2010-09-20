class ResourcesController < ApplicationController
  layout "application"
  before_filter :in_resources
  
  def index
    @entries = Entry.all;
    
  end

  def in_resources
    @in_resources = true;
  end

end
