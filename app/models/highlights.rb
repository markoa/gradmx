
class Highlights < TokyoRecord

  cattr_accessor :table, :port
  @@table = nil
  @@port = 19870

  def initialize(options = {})
    self.class.init_connection(@@port)
    super(options)
  end

  class << self # Class methods
    def init_connection(port = nil)
      port ||= @@port
      @@table = Rufus::Tokyo::TyrantTable.new('localhost', port) if @@table.nil?
    end
  end

end
