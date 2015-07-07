class Hashtag < ActiveRecord::Base

  belongs_to :user
  belongs_to :book

  searchkick
  def self.text_search(query, page)
    if query.present?
      self.search query, page: page, per_page: 5
    end
  end
  
end
