class LocationsController < ApplicationController

  before_filter :login_required, :except => ['index', 'show']
  before_filter :find_location, :only => ['edit', 'update', 'destroy', 'show']

  autocomplete_for :location, :name do |locations|
    locations.map { |loc| "#{loc.name}|#{loc.city.name}|#{loc.id}" }.join("\n")
  end

  # GET /locations
  # GET /locations.xml
  def index
    respond_to do |format|
      format.html { # index.html.erb
        store_page_view
        @locations = Location.paginate(:page => params[:page],
                                       :order => 'name ASC')
      }
      format.xml  {
        @locations = Location.all(:order => 'name ASC')
        render :xml => @locations
      }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new params[:location].merge(:user => @user)

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Location was successfully created.'
        format.html { redirect_to @location }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  # GET /locations/1/edit
  def edit
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    respond_to do |format|
      Location.transaction do
        if @location.update_attributes params[:location] 
          flash[:notice] = "Location was successfully updated."
          format.html { redirect_to @location }
          format.xml  { head :ok }
        else
          format.html { render :action => 'edit' }
          format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.xml  { head :ok }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    respond_to do |format|
      format.html { # show.html.erb
        store_page_view(:location_id => @location.id)
      }
      format.xml  { render :xml => @location }
    end
  end

  protected

  def find_location
    @location = Location.find params[:id]
  end

end
