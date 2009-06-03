class CommentsController < ApplicationController

  before_filter :login_required, :except => 'index'
  before_filter :find_event

  def index
    redirect_to @event
  end

  def create
    @comment = @user.comments.build(params[:comment].merge(:event_id => @event.id))
    if @comment.save
      flash[:notice] = "Your comment has been published"
    else
      flash[:notice] = "Could not save that comment"
    end
    redirect_to @event
  end

  def destroy
  end

  protected

  def find_event
    @event = Event.find(params[:event_id])
  end

end
