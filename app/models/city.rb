class City < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :country_name
  # No code validation to confuse the user, it's handled in the logic.

  # Retrieves existing City based on user input or creates a new instance
  # which can be saved.
  #
  # Always use this instead of manually creating or retrieving cities
  # when handling user input.
  def self.parse(input, country_name)
    code = String.new
    code = input.to_slug unless input.blank?
    existing = City.find_by_code_and_country_name(code, country_name)
    if existing.nil?
      City.new(:name => input, :code => code, :country_name => country_name)
    else
      existing
    end
  end

end
