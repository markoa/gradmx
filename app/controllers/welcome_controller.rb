class WelcomeController < ApplicationController

  before_filter :store_page_view

  def index
    @highlights = Event.highlights
  end

  def change_language
    session[:locale] = params[:locale] unless params[:locale].blank?
    redirect_to :back
  end

end
