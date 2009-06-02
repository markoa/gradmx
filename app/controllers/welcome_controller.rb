class WelcomeController < ApplicationController

  def index
    if logged_in?
      @highlights = Event.highlights
    end
  end

end
