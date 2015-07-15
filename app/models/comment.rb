class Comment < ActiveRecord::Base
  include Twitter::Extractor
  after_save :check_for_hashtags
  
	belongs_to :book
  belongs_to :user
	validates :content, :user_id, :book_id, presence: true

  private
      def check_for_hashtags

        usernames = extract_mentioned_screen_names(content)
        usernames.each do |username| 
          user = User.find_by(username: username)
          if self.user_id != user.id
            Bulletin.create(user_id: user.id,
                            content: "#{self.user.username.capitalize} mentioned you in a comment.",
                            url: "/story/#{self.book.id}",
                            notifier: self.user.id)
          end
        end

        hashtags = extract_hashtags(self.content)
        hashtags.each do |hashtag|
          Hashtag.create content: self.content, 
                          tag: hashtag, 
                          user_id: self.user_id, 
                          book_id: self.book_id,
                          hashtag_type: "comment_content"
        end
      end
end
