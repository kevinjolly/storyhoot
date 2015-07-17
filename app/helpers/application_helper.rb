module ApplicationHelper
  include Twitter::Extractor
  
  def categories
    Category.all
  end

  def full_title
    if current_user
      unread_count = current_user.bulletins.unread_by(current_user).count
      if unread_count > 0
        return 'Storyhoot (' + current_user.bulletins.unread_by(current_user).count.to_s + ')'
      end
    end
    return 'Storyhoot! Share your story with the world'
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