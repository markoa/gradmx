#!/usr/bin/env ruby

require 'rubygems'
require 'rufus/tokyo'

t = Rufus::Tokyo::Table.new('table.tct')

t['pk0'] = { 'name' => 'milan', 'age' => '24' }
t['pk1'] = { 'name' => 'ratko', 'age' => '18' }

# primer transakcije
t.transaction do
  t['pk2'] = { 'name' => 'slavko', 'age' => '45' }
  t['pk3'] = { 'name' => 'jovana', 'age' => '77' }
  t['pk4'] = { 'name' => 'milica', 'age' => '32' }
end

p t.query { |q|
  q.add_condition 'age', :numge, '32'
  q.order_by 'age'
}
# => [ {"name"=>"milica", :pk=>"pk4", "age"=>"32"},
#      {"name"=>"slavko", :pk=>"pk2", "age"=>"45"} ]
#      {"name"=>"jovana", :pk=>"pk3", "age"=>"77"} ]

t.close
