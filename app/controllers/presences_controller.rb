class PresencesController < ApplicationController

  before_filter :login_required, :find_event

  # POST /events/1/presences
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

        format.js # create.js.erb
      end
    else
      respond_to do |format|
        format.html do
          flash[:notice] = "You have already announced your presence"
          redirect_to(@event)
        end

        format.js
      end
    end
  end

  # DELETE /events/1/presences/2
  def destroy
    @presence = Presence.find_by_key(params[:id])
    @presence.destroy if @presence

    flash[:notice] = "You have cancelled your presence"
    redirect_to(@event)
  end

  protected

  def find_event
    Presence.new
    @event = Event.find(params[:event_id])
  end
end
