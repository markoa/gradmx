# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include AuthenticatedSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :find_user, :set_locale

  protected

  def find_user
    @user = current_user
  end

  def set_locale
    if session[:locale] and I18n.available_locales.include?(session[:locale].to_sym)
      I18n.locale = session[:locale]
    else
      I18n.locale = :"sr-Latn"
    end
  end

  def assure_not_logged_in
    redirect_back_or_default(root_path) if logged_in?
  end

  def store_page_view(extra_params = {})
    extra_params[:user_id] = @user.id if @user
    @page_view = PageView.create(request, extra_params)
  end

end
