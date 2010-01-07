class TweetsController < ApplicationController
  before_filter :get_twitterer
  
  # GET /tweets
  # GET /tweets.xml
  def index
    @tweets = @twitterer.nil? ? Tweet.all : @twitterer.tweets

    respond_to do |format|
      format.html {
        digest_authenticate
      }
      format.xml  { render :xml => @tweets }
      format.json { render :json => @tweets }
    end
  end

  # GET /tweets/1
  # GET /tweets/1.xml
  def show
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html {
        digest_authenticate
      }
      format.xml  { render :xml => @tweet }
      format.json { render :json => @tweet }
    end
  end

  # GET /tweets/new
  # GET /tweets/new.xml
  # def new
  #   @tweet = Tweet.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @tweet }
  #   end
  # end

  # GET /tweets/1/edit
  # def edit
  #   @tweet = Tweet.find(params[:id])
  # end

  # POST /tweets
  # POST /tweets.xml
  # def create
  #   @tweet = Tweet.new(params[:tweet])
  # 
  #   respond_to do |format|
  #     if @tweet.save
  #       flash[:notice] = 'Tweet was successfully created.'
  #       format.html { redirect_to(@tweet) }
  #       format.xml  { render :xml => @tweet, :status => :created, :location => @tweet }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @tweet.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /tweets/1
  # PUT /tweets/1.xml
  # def update
  #   @tweet = Tweet.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @tweet.update_attributes(params[:tweet])
  #       flash[:notice] = 'Tweet was successfully updated.'
  #       format.html { redirect_to(@tweet) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @tweet.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /tweets/1
  # DELETE /tweets/1.xml
  # def destroy
  #   @tweet = Tweet.find(params[:id])
  #   @tweet.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(tweets_url) }
  #     format.xml  { head :ok }
  #   end
  # end
  
  private
    
    def get_twitterer
      begin
        @twitterer = Twitterer.find(params[:twitterer_id])
      rescue
      end
    end
end
