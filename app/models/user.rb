require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  belongs_to :city

  has_many :locations # published
  has_many :events    # published

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
 
  validates_presence_of     :city

  # Prevents a user from submitting a crafted form that bypasses activation;
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :city_attributes, :city_id


  # Authenticates a user by their login name and unencrypted password.
  # Returns the user or nil.
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  validate do |usr|
    usr.validate_city
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  # City is a nested attribute
  def city
    c = City.find(self.city_id) unless self.city_id.nil?
    c || @city || build_city
  end

  def city_attributes=(attrs)
    c = City.parse(attrs['name'], attrs['country_name'])
    c.save if c.new_record?
    write_attribute('city_id', c.id)
  end

  def validate_city
    unless city.valid?
      city.errors.each_full { |msg| errors.add(:city, "is invalid: #{msg}") }
    end
  end

end
