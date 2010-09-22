class FoldersController < ApplicationController
  layout "application"
  before_filter :authorize, :except => [:index, :show]

  HIDDEN_FTYPE = 0
  OTHERS_FTYPE = 1
  SERMONSERIES_FTYPE = 2
  FORMS_FTYPE = 3
  EVENTS_FTYPE = 4

  @@folder_type_string = { HIDDEN_FTYPE => "Hidden", OTHERS_FTYPE => "Others" , SERMONSERIES_FTYPE => "Sermon Series" , FORMS_FTYPE => "Forms", EVENTS_FTYPE => "Events"}

  helper_method :get_folder_type_selection_object
  helper_method :get_folder_type_string

  # GET /folders
  # GET /folders.xml
  def index
    @folders = Folder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @folders }
    end
  end

  # GET /folders/1
  # GET /folders/1.xml
  def show
    @folder = Folder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @folder }
    end
  end

  # GET /folders/new
  # GET /folders/new.xml
  def new
    @folder = Folder.new
    @new = true;
    respond_to do |format|
      format.html { render "edit" }
      format.xml  { render :xml => @folder }
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id])
  end

  # POST /folders
  # POST /folders.xml
  def create
    @folder = Folder.new(params[:folder])
    puts @folder.inspect

    respond_to do |format|
      if @folder.save
        flash[:notice] = 'Folder was successfully created.'
        format.html { redirect_to(@folder) }
        format.xml  { render :xml => @folder, :status => :created, :location => @folder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /folders/1
  # PUT /folders/1.xml
  def update
    @folder = Folder.find(params[:id])

    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        flash[:notice] = 'Folder was successfully updated.'
        format.html { redirect_to(@folder) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.xml
  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to(folders_url) }
      format.xml  { head :ok }
    end
  end

  def get_folder_type_selection_object
    return @@folder_type_string.keys.map {|k| [@@folder_type_string[k], k] }
  end  

  def get_folder_type_string(k)
    return @@folder_type_string[k]
  end  

end
