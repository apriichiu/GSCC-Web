class AttachmentsController < ApplicationController
  layout "application"
  before_filter :authorize, :except => [:index, :show]


  # GET /attachments
  # GET /attachments.xml
  def index
    @attachments = Attachment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attachments }
    end
  end

  # GET /attachments/1
  # GET /attachments/1.xml
  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/new
  # GET /attachments/new.xml
  def new
    @attachment = Attachment.new
    @entries = Entry.find(:all, :order => "updated_at DESC").map { |e| [e.title, e.id] }

    @new = true;
    
    respond_to do |format|
      format.html { render "edit" } # edit.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])
    @entries = Entry.find(:all, :order => "updated_at DESC").map { |e| [e.title, e.id] }
  end

  # POST /attachments
  # POST /attachments.xml
  def create
    @attachment = Attachment.new(params[:attachment])

    respond_to do |format|
      if @attachment.save
        flash[:notice] = 'Attachment was successfully created.'
        format.html { redirect_to(@attachment) }
        format.xml  { render :xml => @attachment, :status => :created, :location => @attachment }
      else
        flash[:notice] = 'Attachment creation failed.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attachments/1
  # PUT /attachments/1.xml
  def update
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        flash[:notice] = 'Attachment was successfully updated.'
        format.html { redirect_to(@attachment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.xml
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to(attachments_url) }
      format.xml  { head :ok }
    end
  end
end
