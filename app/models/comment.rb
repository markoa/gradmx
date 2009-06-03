class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates_presence_of :body, :user_id, :event_id
end
