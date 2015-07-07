class ReportedBook < ActiveRecord::Base
	validates :user_id, :book_id, presence: true
end
