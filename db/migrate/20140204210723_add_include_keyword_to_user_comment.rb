class AddIncludeKeywordToUserComment < ActiveRecord::Migration
  def change
    add_column :user_comments, :include_keyword, :boolean
  end
end
