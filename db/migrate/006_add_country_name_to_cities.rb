class AddCountryNameToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :country_name, :string
  end

  def self.down
    remove_column :cities, :country_name
  end
end
