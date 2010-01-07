require 'grackle'

class Twitterer < ActiveRecord::Base
  has_many :tweets, :primary_key => :twitterer_id, :dependent => :destroy, :order => "tweets.created_at DESC"

  named_scope :active, :conditions => {:active => true}
  
  validates_uniqueness_of :screen_name
  
  before_save :get_twitterer_infos_from_api
  after_save :get_tweets_from_api
  
  def self.grackle_client
    @@grackle_client||= Grackle::Client.new
    return @@grackle_client
  end

  def get_twitterer_infos_from_api    
    # only fetch infos if active and infos not fetched yet
    if self.active && self.twitterer_id.nil?
      self.get_twitterer_infos(Twitterer.grackle_client)
    end
  end
  
  def get_tweets_from_api(delayed=true)
    # only fetch infos if active and infos not fetched yet
    # if self.active && self.tweets.empty?
    if self.active
      if delayed
        self.send_later :get_tweets, Twitterer.grackle_client
      else
        get_tweets(Twitterer.grackle_client)
      end
    end
  end
  
  
  
  def get_twitterer_infos(client)
    twitter_struct = client.users.show.json? :screen_name => self.screen_name
        
    self.twitterer_id         = twitter_struct.id
    self.time_zone            = twitter_struct.time_zone
    self.time_zone            = twitter_struct.time_zone
    self.utc_offset           = twitter_struct.utc_offset
    self.profile_image_url    = twitter_struct.profile_image_url
    self.url                  = twitter_struct.url
    self.location             = twitter_struct.location
    self.name                 = twitter_struct.name
    self.description          = twitter_struct.description
    self.twitterer_created_at = twitter_struct.created_at
  end
  
  def get_tweets(client)
    # you can only get max 3200 tweets : 200 * 16
    count = 200
    max_nb_pages = 16
    
    # get max tweet id
    max_tweet_id = self.tweets.maximum('tweet_id') unless self.tweets.empty?
    max_tweet_id||=0
    last_max_tweet_id = -1
    
    logger.error("\n\n--\nmax_tweet_id : #{max_tweet_id}\n--\n\n")
    
    
    current_page = 1 
    
    while (current_page <= max_nb_pages) && (max_tweet_id > last_max_tweet_id)
      logger.error("\n\n--\nFetching page #{current_page}\n--\n\n")
      
      if max_tweet_id==0
        twitter_struct = client.statuses.user_timeline.json? :screen_name => self.screen_name, :count => count, :page => current_page
      else
        twitter_struct = client.statuses.user_timeline.json? :screen_name => self.screen_name, :count => count, :page => current_page, :since_id => max_tweet_id
      end
      
      Tweet.init_with_grackle_structs(twitter_struct)

      max_tweet_id = self.tweets.maximum('tweet_id') unless self.tweets.empty?
      max_tweet_id||=0
      
      current_page+=1
    end
  end
  
end