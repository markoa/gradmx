
# PageView always has the following fields:
#
# request_uri
# remote_ip
# referer
# user_agent
# created_at
# updated_at
#
# and when applicable:
#
# user_id
# event_id
# location_id
#
class PageView < TokyoRecord

  cattr_accessor :table, :port
  @@table = nil
  @@port = 19850

  # Request may be an ActionController::Request, or a Hash.
  # In the former case, options may include additional data such as event_id.
  def initialize(request, options = {})
    self.class.init_connection(@@port)

    if request.is_a?(Hash)
      init_existing(request)
    elsif request.is_a?(ActionController::Request)
      init_new(request, options)
    end
  end

  class << self # Class methods

    # TokyoRecord implementation
    def init_connection(port = nil)
      port ||= @@port
      @@table = Rufus::Tokyo::TyrantTable.new('localhost', port) if @@table.nil?
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
    @data['referer'] = request.referer || ''
    @data['user_agent'] = request.user_agent

    append_to_data(options)
  end

  def init_existing(hash)
    @key = hash[:pk]
    @data = Hash.new
    append_to_data(hash)
  end

end
