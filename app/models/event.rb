class Event < ActiveRecord::Base

  belongs_to :location
  belongs_to :user # publisher

  has_many :comments

  validates_presence_of :title
  validates_presence_of :time_begin
  validates_presence_of :location

  autocomplete_for 'location', 'name' # adds auto_location_name=

  # Read by will_paginate
  def self.per_page
    10
  end

  def self.upcoming
    find(:all, :conditions => ["time_begin >= ?", Time.now.utc])
  end

  def self.highlights
    events = []
    ::Highlights.new
    for k in Highlights.table.keys(:prefix => "event").reverse[0..9].reverse
      events << Event.find(Highlights.table[k]["id"].to_i)
    end
    events
  end

  def validate
    if not time_end.blank? and not time_begin.blank? and time_end <= time_begin
      errors.add("time_end", "must be after the beginning time")
    end

    if self.new_record? and not time_begin.blank? and time_begin <= Time.now.utc
      errors.add("time_begin", "must be in the future")
    end
  end

  def presences
    Presence.query { |q| q.add 'event_id', :equals, self.id.to_s }
  end

end
