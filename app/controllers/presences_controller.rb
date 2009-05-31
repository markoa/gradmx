class PresencesController < ApplicationController

  before_filter :login_required, :find_event

  # POST /events/1/presences
  # TODO: POST /events/1/presences.xml
  def create
    existing = Presence.query do |q|
      q.add "user_id", :eq, @user.id.to_s
      q.add "event_id", :eq, @event.id.to_s
    end

    if existing.empty?
      @presence = Presence.create(:event_id => @event.id, :user_id => @user.id)
      respond_to do |format|
        format.html do
          flash[:notice] = "You have announced your presence"
          redirect_to(@event)
        end
        # requires TokyoRecord#to_xml
        #format.xml  { render :xml => @presence, :status => :created, :location => @event }
      end
    else
      respond_to do |format|
        format.html do
          flash[:notice] = "You have already announced your presence"
          redirect_to(@event)
        end
        #format.xml  { render :xml => @presence, :status => :created, :location => @event }
      end
    end
  end

  # DELETE /events/1/presences/2
  # DELETE /events/1/presences/2.xml
  def destroy
    @presence = Presence.find_by_key(params[:id])
    @presence.destroy if @presence

    respond_to do |format|
      format.html do
        flash[:notice] = "You have cancelled your presence"
        redirect_to(@event)
      end
      format.xml { head :ok }
    end
  end

  protected

  def find_event
    Presence.new
    @event = Event.find(params[:event_id])
  end
end
