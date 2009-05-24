class TokyoRecord

  # Raised when the descendant model does not define init_connection
  # or doesn't set the @@table class variable.
  class ConnectionError < StandardError
  end

  def initialize
    @data, @key = nil
  end

  def self.init_connection
    raise ConnectionError, "You need to implement init_connection in your model"
  end

  def table
    t = self.class.table
    if t.nil? or not t.is_a?(Rufus::Tokyo::TyrantTable)
      raise ConnectionError, "No connection to Tokyo Tyrant"
    end
    return t
  end

  def connected?
    !table.nil?
  end

  def new_record?
    @key.nil?
  end

  def save
    time = Time.current.to_s
    if new_record?
      @key = table.genuid.to_s
      @data["created_at"] = time
    end

    @data["updated_at"] = time
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
      records.each { |r| objects << new(r) }
      objects
    end

    def count
      table.size
    end

    def create(request, options = {})
      object = new(options)
      object.save
      object
    end

    def first
      keys = table.query { |q| q.pk_only }
      table[keys.first]
    end

    def last
      keys = table.query { |q| q.pk_only }
      table[keys.last]
    end
  end

  protected

  # Should be used instead of @data.merge, as we must have only strings as keys
  def append_to_data(hash)
    hash.each { |k, v| @data[k.to_s] = v.to_s }
  end

end
