class Location < ActiveRecord::Base

  belongs_to :user
  belongs_to :city

  validates_presence_of :name
  validates_presence_of :city

  validates_uniqueness_of :name, :scope => :city_id, :case_sensitive => false, :message => "is already published"

  validate do |loc|
    loc.validate_city
  end

  # City is a nested attribute
  def city
    c = City.find(self.city_id) unless self.city_id.nil?
    c || @city || build_city
  end

  def city_attributes=(attrs)
    c = City.parse(attrs['name'])
    c.save if c.new_record?
    write_attribute('city_id', c.id)
  end

  def validate_city
    unless city.valid?
      city.errors.each_full { |msg| errors.add(:city, "is invalid: #{msg}") }
    end
  end
end
