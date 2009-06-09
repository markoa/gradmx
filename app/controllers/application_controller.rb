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
    I18n.locale = session[:locale].blank? ? :"sr-Latn" : session[:locale].to_sym

    # Putting this inside an initializer file would always show them in
    # the default locale and would not honor the requested
    WillPaginate::ViewHelpers.pagination_options[:previous_label] =
      I18n.t('general.previous_page')

    WillPaginate::ViewHelpers.pagination_options[:next_label] =
      I18n.t('general.next_page')
  end

  def assure_not_logged_in
    redirect_back_or_default(root_path) if logged_in?
  end

  def store_page_view(extra_params = {})
    extra_params[:user_id] = @user.id if @user
    @page_view = PageView.new(request, extra_params)
    @page_view.save
  end

end
