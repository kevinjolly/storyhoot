class Subscription < ActiveRecord::Base
	belongs_to :author, class_name: 'User'
	belongs_to :subscriber, class_name: 'User'
  after_save :send_notification

  private
      def send_notification
        Bulletin.create(user_id: self.author.id,
                        content: "#{self.subscriber.username.capitalize} subscribed to you.",
                        url: "/u/#{self.subscriber.username}",
                        notifier: self.subscriber.id)
      end
end
