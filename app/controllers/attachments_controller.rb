class AttachmentsController < ApplicationController
  layout "application"
  before_filter :authorize, :except => [:index, :show]

  # GET /attachments
  # GET /attachments.xml
  def index
    @attachments = Attachment.find(:all, :order => "updated_at DESC");
    puts Attachment.column_names

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

    respond_to do |format|
      format.html
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
    @attachment = Attachment.new
    @entries = Entry.find(:all, :order => "updated_at DESC").map { |e| [e.title, e.id] }
    #Since we're using swfUpload, the file will be in params[:Filedata]
    #We need to change the content_type since swfUpload messes it up
    params[:Filedata].content_type = MIME::Types.type_for(params[:Filename]).to_s

    #Set the object to be the file uploaded
    @attachment.object = params[:Filedata]
    #Set the entry_id if there is one
    @attachment.entry_id = params[:entry_id]

    if @attachment.save
      flash[:notice] = 'Attachment was successfully created.'
      output = @attachment.object_file_name + " successfully uploaded";
      if params[:entry_id]
        output += " to "+Entry.find(params[:entry_id]).title
      end
      render :text => output
    else
      flash[:error] = 'Attachment creation failed.'
      render :action => "edit"
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
