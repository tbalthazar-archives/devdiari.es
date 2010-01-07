class CreateTwitterers < ActiveRecord::Migration
  def self.up
    create_table :twitterers do |t|
      t.integer   :twitterer_id, :limit => 8
      t.string    :screen_name
      t.string    :time_zone
      t.string    :utc_offset
      t.string    :profile_image_url
      t.string    :url
      t.string    :location
      t.string    :name
      t.string    :description
      t.datetime  :twitterer_created_at

      t.timestamps
    end

    add_index :twitterers, :screen_name,  :unique => true
    add_index :twitterers, :twitterer_id, :unique => true
  end

  def self.down
    drop_table :twitterers
  end
end
