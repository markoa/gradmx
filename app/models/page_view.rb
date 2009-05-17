
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
class PageView

  cattr_accessor :table
  @@table = nil

  # Request may be an ActionController::Request, or a Hash.
  # In the former case, options may include additional data such as event_id.
  def initialize(request, options = {})
    if request.is_a?(Hash)
      init_existing(request)
    elsif request.is_a?(ActionController::Request)
      init_new(request, options)
    end
  end

  def table
    return self.class.table
  end

  def connected?
    !table.nil?
  end

  def save
    if @key.nil?
      @key = table.genuid.to_s
    end
    table[@key] = @data
  end

  def destroy
    table.delete(@key)
  end

  def method_missing(key, *args)
    text = key.to_s

    if text[-1, 1] == "=" # if key ends with = then set a value
      @data[text.chop.to_sym] = args.first
    else
      if @data.keys.include?(text)
        if text[-2, 2] == "id"
          @data[text].to_i
        else
          @data[text]
        end
      else
        super
      end
    end
  end

  class << self # Class methods
    def all
      records = table.query { |q| }
      objects = []
      records.each { |r| objects << PageView.new(r) }
      objects
    end

    def count
      table.size
    end

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

  # Should be used instead of merge, as we must have only strings as keys
  def append_to_data(hash)
    hash.each { |k, v| @data[k.to_s] = v.to_s }
  end

end
