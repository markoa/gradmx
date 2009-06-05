class CommentsController < ApplicationController

  before_filter :login_required, :except => 'index'
  before_filter :find_event

  def index
    redirect_to @event
  end

  def create
    @comment = @user.comments.build(params[:comment].merge(:event_id => @event.id))
    @success = @comment.save
    if @success
      @msg = "Your comment has been published"
    else
      @msg = "Could not save that comment"
    end

    respond_to do |format|
      format.html do
        flash[:notice] = @msg
        redirect_to @event
      end

      format.js
    end
  end

  def destroy
  end

  protected

  def find_event
    @event = Event.find(params[:event_id])
  end

end
