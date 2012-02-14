class EventsController < ApplicationController

  layout "application"
  before_filter :in_events;
  before_filter :authorize, :only => [:backend, :registrants]

  def index
  end

  def in_events
    @in_events = true;
  end

  def backend
    #we already have @upcoming_events from the controller
    if !params["checkbox"].nil?
      @upcoming_events.each do |e|
        if params["checkbox"].find{ |c| e.id == c[0].to_i }
          e.reg = 1
          e.save
        else
          e.reg = 0
          e.save
        end
      end
    end
    if !params["paypal"].nil?
      puts params["paypal"].inspect
      @upcoming_events.each do |e|
        if params["paypal"].find{ |c| e.id == c[0].to_i }
          e.paypal = params["paypal"][e.id.to_s]
          e.save
        end
      end
    end
  end
  
  def registration
    if params.nil? || params[:id].nil?
      redirect_to events_path
    end
    
    e = FacebookEvent.find(:first, :conditions => ["id = ?", params[:id]])
    if e.nil? || !e.reg 
      redirect_to events_path
    end
    
    @event = e;
  end

  def register
    if params[:eid].nil?
      redirect_to events_path
    end
    @event = FacebookEvent.find(params[:eid])
    if params[:rid].nil?
      @reg = Registration.new(params[:reg])
      @reg.password = Digest::SHA256.hexdigest(Time.now.to_s);
      @reg.event_id = params[:eid]
      @reg.save
      @reg.deliver_confirmation
    else
      @reg = Registration.find(params[:rid])
      @reg.update_attributes(params[:reg])
      @reg.save
    end

    @newregistrant = 1
  end

  def registrants
    if params[:eid].nil?
      redirect_to events_path
    end

    success_array = []
    delete_array = []
    @event = FacebookEvent.find(params[:eid])
    @registrants = Registration.find(:all, :conditions => ["event_id = ?", params[:eid]]);

    @registrants.each do |r|
      if params["submit"] == "submit" 
        old_status = r.paid;
        r.paid = ((params[:paying].nil?) || (params[:paying][r.id.to_s].nil?)) ? 0 : 1
        new_status = r.paid
        r.save
        if !(old_status - new_status == 0)
          success_array <<  r.fullname
          if new_status == 1
            r.deliver_payment
          end
        end
        if !params[:delete].nil? && params[:delete][r.id.to_s] == "on"
          r.delete
          delete_array << r.fullname
        end
      end
    end
    @registrants = Registration.find(:all, :conditions => ["event_id = ?", params[:eid]]);
    notice = ""
    if success_array.size > 0
      notice += "Successfully modified the following people's payment status: " + success_array.join(", ") + ". "
    end
    if delete_array.size > 0
      notice += "Successfully deleted the following people's payment status: " + delete_array.join(", ") + ". "
    end
    if notice != ""
      flash[:notice] = notice
    end
  end

  def registration_confirmation
    if !params[:id].nil?
      @reg = Registration.find(params[:id])
      if params[:pw] != @reg.password
        flash[:error] = "Invalid password"
        redirect_to events_path
      else
        @event = FacebookEvent.find(@reg.event_id)
        render "register"
      end
    else
      redirect_to events_path
    end
  end
end
