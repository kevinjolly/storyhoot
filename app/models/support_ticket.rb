class SupportTicket < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :title, presence: true
  validates :question, presence: true
end
