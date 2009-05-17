class TokyoRecord

  def initialize
    @data, @key = nil
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
  end

  protected

  # Should be used instead of @data.merge, as we must have only strings as keys
  def append_to_data(hash)
    hash.each { |k, v| @data[k.to_s] = v.to_s }
  end

end
