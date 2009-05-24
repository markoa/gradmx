class UsersController < ApplicationController

  before_filter :assure_not_logged_in, :except => ['show']
  before_filter :store_page_view
  
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!

    @user = User.new(params[:user])
    @user.save!

    self.current_user = @user # now logged in

    flash[:notice] = "Thanks for signing up!"
    redirect_back_or_default('/')

  rescue ActiveRecord::RecordInvalid
    flash[:error]  = "We couldn't set up that account, sorry."
    render :action => 'new'
  end

  def show
    @req_user = User.find(params[:id])
  end

end
