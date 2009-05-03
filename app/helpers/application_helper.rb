# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def page_h(text)
    content_for :page_header do
      text
    end
  end

end
