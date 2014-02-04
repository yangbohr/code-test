class UserComment < ActiveRecord::Base
  require 'open-uri'
  KEYWORDS = %w(coke coca-cola diet-cola)
  URL = 'http://iqmi-dev-test-api.herokuapp.com/tweets.json '

  def self.fetch_comments(url)
    comments_array = JSON.parse open(url).read
    puts comments_array
    if comments_array.is_a?(Hash)
      return 'this is an error in fetching comments'
      puts comments_array
    end
    comments = comments_array.map do |comment|

      key_word_include = false
      KEYWORDS.each do |key_word|
        if comment["message"].downcase.include? key_word
          key_word_include = true
          break
        end
      end

      {
          creation_time: comment["created_at"],
          user_id: comment["id"],
          follower: comment["followers"],
          score: comment["sentiment"].to_f,
          handle: comment["user_handle"],
          message: comment["message"],
          include_keyword: key_word_include
      }
    end
    UserComment.create(comments.compact)
  end

end
