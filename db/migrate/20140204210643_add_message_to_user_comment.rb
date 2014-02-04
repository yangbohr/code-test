class AddMessageToUserComment < ActiveRecord::Migration
  def change
    add_column :user_comments, :message, :string
  end
end
