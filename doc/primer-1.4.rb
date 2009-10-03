#!/usr/bin/env ruby

require 'rubygems'
require 'rufus/tokyo/tyrant'

# Server se pokrece sa
# ttserver -port 4321 data.tch
db = Rufus::Tokyo::Tyrant.new('localhost', 4321)

db['key'] = 'tokyo'

p db['key'] # => 'tokyo'
p db.size     # => 1
p db['lost']  # => nil

db.close
