class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :name
      t.string :code
      t.timestamps
    end

    add_index :cities, :code, :unique => true
  end

  def self.down
    remove_index :cities, :code
    drop_table :cities
  end
end
