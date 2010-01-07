class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :tweet_id,      :limit => 8
      t.integer :twitterer_id,  :limit => 8
      t.string  :text
      t.string  :source
      t.boolean :truncated
      t.integer :in_reply_to_status_id, :limit => 8
      t.integer :in_reply_to_user_id,   :limit => 8
      t.boolean :favorited
      t.string :in_reply_to_screen_name

      t.timestamps
    end
    
    add_index :tweets, :tweet_id, :unique => true
  end

  def self.down
    remove_index :tweets, :column => :tweet_id
    drop_table :tweets
  end
end
