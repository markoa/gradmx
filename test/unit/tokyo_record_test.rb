require 'test_helper'
require 'tokyo_record'

class T < Test::Unit::TestCase

  class Lazy < TokyoRecord
    cattr_accessor :table, :port
    @@table = nil
    @@port = 12345
  end

  def test_should_require_implementation
    assert_raise(TokyoRecord::ConnectionError) do
      Lazy.init_connection
    end

    assert_raise(TokyoRecord::ConnectionError) do
      Lazy.count
    end
  end
end
