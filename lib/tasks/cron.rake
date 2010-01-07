require 'grackle'

task :cron => :environment do
  delayed = false
  Twitterer.active.each { |twitterer| twitterer.get_tweets_from_api(delayed) }
end