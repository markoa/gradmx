
# PageView always has the following fields:
#
# user_id
# request_uri
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
class PageView < TokyoRecord

  cattr_accessor :table
  @@table = nil

  # Request may be an ActionController::Request, or a Hash.
  # In the former case, options may include additional data such as event_id.
  def initialize(request, options = {})
    self.class.init_connection

    if request.is_a?(Hash)
      init_existing(request)
    elsif request.is_a?(ActionController::Request)
      init_new(request, options)
    end
  end

  class << self # Class methods

    def init_connection
      self.table = Rufus::Tokyo::TyrantTable.new('localhost', PAGE_VIEWS_PORT) if @@table.nil?
    end

    # TokyoRecord override
    def create(request, options = {})
      object = new(request, options)
      object.save
      object
    end
  end

  private

  def init_new(request, options = {})
    @key = nil
    @data = Hash.new

    @data['request_uri'] = request.request_uri
    @data['remote_ip'] = request.remote_ip

    append_to_data(options)
  end

  def init_existing(hash)
    @key = hash[:pk]
    @data = Hash.new
    append_to_data(hash)
  end

end
