class UsersController < ApplicationController
  
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

end
