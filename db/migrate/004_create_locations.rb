class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.text :description
      t.references :city
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
