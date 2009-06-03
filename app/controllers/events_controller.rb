class EventsController < ApplicationController

  before_filter :login_required, :except => ['index', 'show']

  # GET /events
  # GET /events.xml
  def index
    store_page_view
    respond_to do |format|
      format.html { # index.html.erb
        @events = Event.paginate(:page => params[:page])
        @locations = Location.recent
      }
      format.xml  {
        @events = Event.all
        render :xml => @events
      }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    # Necessary to reinit connection to Tyrant in development mode.
    # Otherwise, @event.presence would raise.
    # TODO: is there another way?
    Presence.new

    @event = Event.find(params[:id])
    store_page_view(:event_id => @event.id)

    if logged_in?
      @comment = Comment.new

      attending_results = Presence.query do |q|
        q.add "user_id", :eq, @user.id.to_s
        q.add "event_id", :eq, @event.id.to_s
      end

      @presence = attending_results.empty? ? nil : attending_results.first
    end

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
    store_page_view(:event_id => @event.id)
  end

  # POST /events
  # POST /events.xml
  def create
    @event = @user.events.new(params[:event])

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
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
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
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
end
