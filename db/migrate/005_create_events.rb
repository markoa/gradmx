class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :time_begin
      t.datetime :time_end
      t.references :user
      t.references :location

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
