module ApplicationHelper
  include Twitter::Extractor
  
  def categories
    Category.all
  end

  def auto_link(content)

    usernames = extract_mentioned_screen_names(content)
    usernames.each do |username|
      content.sub!('@' + username, "<a href=\"/u/#{username}\">@#{username}</a>")
    end

    hashtags = extract_hashtags(content)
    hashtags.each do |hashtag|
      content.sub!('#' + hashtag, "<a href=\"/hashtags?query=%23#{hashtag}\">##{hashtag}</a>")
    end
    return content
  end
end