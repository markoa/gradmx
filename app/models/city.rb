class City < ActiveRecord::Base

  validates_presence_of :name
  # No code validation to confuse the user, it's handled in the logic.

  # Retrieves existing City based on user input or creates a new instance
  # which can be saved.
  #
  # Always use this instead of manually creating or retrieving cities
  # when handling user input.
  def self.parse(input)
    code = String.new
    code = input.to_slug unless input.blank?
    existing = City.find_by_code(code)
    existing.nil? ? City.new(:name => input, :code => code) : existing
  end

end
