class Tweet < ActiveRecord::Base
  belongs_to :twitterer, :foreign_key => :twitterer_id, :primary_key => :twitterer_id
  
  
  def self.init_with_grackle_struct(grackle_struct)
    tweet = Tweet.new
    
    tweet.tweet_id                 = grackle_struct.id
    tweet.twitterer_id             = grackle_struct.user.id
    tweet.text                     = grackle_struct.text
    tweet.source                   = grackle_struct.source
    tweet.truncated                = grackle_struct.truncated
    tweet.in_reply_to_status_id    = grackle_struct.in_reply_to_status_id
    tweet.in_reply_to_user_id      = grackle_struct.in_reply_to_user_id
    tweet.favorited                = grackle_struct.favorited
    tweet.in_reply_to_screen_name  = grackle_struct.in_reply_to_screen_name
    tweet.created_at               = grackle_struct.created_at
    
    tweet.save
    logger.error("\n\n--\na tweet should have been created\n--\n\n")
  end
  
  def self.init_with_grackle_structs(grackle_structs)
    logger.error("\n\n--\n#{grackle_structs.length} tweets should be created\n--\n\n")
    grackle_structs.each { |grackle_struct| Tweet.init_with_grackle_struct(grackle_struct) }
  end
  
end