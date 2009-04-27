class Location < ActiveRecord::Base

  belongs_to :user
  belongs_to :city

  validates_presence_of :name
  validates_presence_of :city

  validates_uniqueness_of :name, :scope => :city_id, :case_sensitive => false

end
