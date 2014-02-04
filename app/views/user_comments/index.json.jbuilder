json.array!(@user_comments) do |user_comment|
  json.extract! user_comment, :id, :handle, :user_id, :creation_time, :score, :follower
  json.url user_comment_url(user_comment, format: :json)
end
