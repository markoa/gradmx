
# PageView always has the following fields:
#
# user_id
# request_url
# ip_address
# referer
# user_agent
# created_at
#
# and when applicable:
#
# event_id
# location_id
#
class PageView

  cattr_accessor :table
  @@table = nil

  # request is an ActionController::Request
  # options may include additional data such as event_id
  def initialize(request, options = {})
  end

  def connected?
    !@@table.nil?
  end
end
