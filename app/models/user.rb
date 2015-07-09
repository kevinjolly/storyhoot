class User < ActiveRecord::Base

  authenticates_with_sorcery! do |config|
  	config.authentications_class = Authentication
  end
  
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  
	acts_as_reader
	acts_as_voter

	searchkick
	def self.text_search(query, page)
		if query.present?
			self.search query, boost_by: [:total_view_count], page: page, per_page: 6
		end
	end
	
	has_many :books, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :bulletins, dependent: :destroy
	has_many :uploads, dependent: :destroy
	has_many :hashtags, dependent: :destroy

	has_many :subscriptions, :foreign_key => 'author_id'
	has_many :subscribers, through: :subscriptions

	has_many :reverse_subscriptions, :foreign_key => 'subscriber_id', :class_name => 'Subscription'
	has_many :authors, through: :reverse_subscriptions

	validates :username, uniqueness: { case_sensitive: false} , presence: true
	validates :email, uniqueness: true, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
	validates :password, presence: true, length: { minimum: 6 }, if: :new_user?

	before_validation :prep_email
	before_save :prep_username
	has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "ProfilePic.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	has_attached_file :cover, :styles => { :cover_size => "1300x440#", :thumb => "100x100#" }, :default_url => "CoverPic.png"
	validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

	def to_param
		"#{username}".parameterize
	end

	def subscribed?(other_user)
		self.reverse_subscriptions.find_by(author_id: other_user.id)
	end

	def subscribe!(other_user)
		self.reverse_subscriptions.create!(author_id: other_user.id, subscriber_id: self.id)
	end

	def unsubscribe!(other_user)
		self.reverse_subscriptions.find_by(author_id: other_user.id, subscriber_id: self.id).destroy
	end

	def feed
		Book.from_users_followed_by(self).order('created_at DESC')
	end

	def reported(book)
		ReportedBook.find_by(book_id: book, user_id: self.id)
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def send_verification_request
		admin_emails = ['prajwalpy6@gmail.com', 'kevinjolly7@hotmail.com']
		admin_emails.each do |email|
			AdminMailer.request_verification(self, email).deliver
		end
	end

	def update_user_total_view_count
		update(total_view_count: self.books.sum(:view_count))
	end

	private

			def generate_token(column)
				begin
					self[column] = SecureRandom.urlsafe_base64
				end while User.exists?(column => self[column])
			end

			def prep_email
				self.email = self.email.strip.downcase if self.email
			end

			def prep_username
				self.username = self.username.strip.downcase if self.username
			end

			def new_user?
				new_record?
			end
end
