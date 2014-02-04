class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.string :handle
      t.integer :user_id
      t.time :creation_time
      t.float :score
      t.integer :follower

      t.timestamps
    end
  end
end
