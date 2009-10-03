#!/usr/bin/env ruby

require 'rubygems'
require 'rufus/tokyo'

db = Rufus::Tokyo::Cabinet.new('data.tch')

db['key'] = 'tokyo'

p db['key'] # => 'tokyo'
p db.size     # => 1
p db['lost']  # => nil

1000.times { |i| db["k#{i}"] = "x" }

p db.keys(:prefix => 'k').size # => 1000

db.delete('key')

db.close
