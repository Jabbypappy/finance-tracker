class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, references: :users, foreign_key: { to_table: :users } # Self_referential, same as user_id, but it identifies as :friend for a friend_id--which is a user_id--something like that 
      t.timestamps
    end
  end
end
