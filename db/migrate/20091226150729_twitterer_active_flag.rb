class TwittererActiveFlag < ActiveRecord::Migration
  def self.up
    add_column :twitterers, :active, :boolean, :default => false
  end

  def self.down
    remove_column :twitterers, :active
  end
end
