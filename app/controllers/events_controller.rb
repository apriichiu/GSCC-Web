class EventsController < ApplicationController
  layout "application"
  # GET /events
  # GET /events.xml
  $password_hash = "0f06bb7d50077b038be79b69ca6f37b271ee3ff4c6e7a790ba7d40473729a646"

  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if  Digest::SHA256.hexdigest(params[:auth][:pass]) == $password_hash
        if @event.save
          flash[:notice] = 'Event was successfully created.'
          format.html { redirect_to(@event) }
          format.xml  { render :xml => @event, :status => :created, :location => @event }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        end
      else
        flash[:notice] = 'Incorrect Password'
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if  Digest::SHA256.hexdigest(params[:auth][:pass]) == $password_hash
        if @event.update_attributes(params[:event])
          flash[:notice] = 'Event was successfully updated.'
          format.html { redirect_to(@event) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        end
      else
        flash[:notice] = 'Incorrect Password.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  def self.recent_events
    @events = Event.find(:all, :order => "startdate", :limit => 3);
    return @events
  end

end
