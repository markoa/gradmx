class WelcomeController < ApplicationController

  def index
    if logged_in?
      @highlights = Event.highlights
    end
  end

  def change_language
    session[:locale] = params[:locale] unless params[:locale].blank?
    redirect_to :back
  end

end
