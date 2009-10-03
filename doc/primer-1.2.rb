#!/usr/bin/env ruby

require 'rubygems'
require 'rufus/tokyo'

db = Rufus::Tokyo::Cabinet.new('data.tcf#width=8')

1000.times { |i| db["score#{i}"] = rand(100) }

p db.weight # => vraca velicinu baze u bajtima
