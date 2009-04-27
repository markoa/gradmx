class Event < ActiveRecord::Base

  belongs_to :location
  belongs_to :user # publisher

  validates_presence_of :title
  validates_presence_of :time_begin
  validates_presence_of :location

  def validate
    if not time_end.blank? and not time_begin.blank? and time_end <= time_begin
      errors.add("time_end", "must be after the beginning time")
    end

    if self.new_record? and not time_begin.blank? and time_begin <= Time.now.utc
      errors.add("time_begin", "must be in the future")
    end
  end

end
