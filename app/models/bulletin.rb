class Bulletin < ActiveRecord::Base
  acts_as_readable :on => :created_at
  belongs_to :user
  validates :user_id, :content, :url, :notifier, presence: true
end
