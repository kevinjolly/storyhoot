class Book < ActiveRecord::Base
	include Twitter::Extractor
	after_save :check_for_hashtags

	acts_as_votable
	is_impressionable :counter_cache => true, :column_name => :view_count, :unique => :all

	belongs_to :user
	belongs_to :category
	has_many :comments, dependent: :destroy
	has_many :hashtags, dependent: :destroy

	validates :title, presence: true
	validates :category, presence: true

	has_attached_file :cover,
		:styles => {
			:thumb => "150x150#"
		},
		:default_url => "BookCoverPic.png",
		:convert_options => {
			:all => "-interlace plane",
			:thumb => "-layers optimize",
			:thumb => "-quality 75"
		}
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

	searchkick

	def self.text_search(query, page)
		if query.present?
			self.search query, boost_by: {cached_votes_total: {factor: 10}, view_count: {factor: 1}}, page: page, per_page: 5
		end
	end

	def self.from_users_followed_by(user)
		author_ids = user.author_ids
		where("user_id IN (:author_ids) OR user_id = :user_id", author_ids: author_ids, user_id: user)
	end

	private
			def check_for_hashtags
				hashtags = extract_hashtags(self.title)
				hashtags.each do |hashtag|
					Hashtag.create content: self.title, 
													tag: hashtag, 
													user_id: self.user_id, 
													book_id: self.id,
													hashtag_type: "book_title"
				end
			end

end
