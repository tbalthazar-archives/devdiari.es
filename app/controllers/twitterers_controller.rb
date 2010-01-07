class TwitterersController < ApplicationController
    before_filter :digest_authenticate, :except => [:index, :create]
    
    # GET /twitterers
    # GET /twitterers.xml
    def index
      # @twitterers = Twitterer.active.all

      respond_to do |format|
        format.html {
          digest_authenticate
          @twitterers = Twitterer.all
        }
        format.xml  { render :xml => @twitterers }
        format.json  {
          @twitterers = Twitterer.active.all
          render :json => @twitterers
        }
      end
    end

    # GET /twitterers/1
    # GET /twitterers/1.xml
    def show
      @twitterer = Twitterer.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @twitterer }
        format.json  { render :json => @twitterer }
      end
    end

    # GET /twitterers/new
    # GET /twitterers/new.xml
    def new
      @twitterer = Twitterer.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @twitterer }
        format.json  { render :json => @twitterer }
      end
    end

    # GET /twitterers/1/edit
    def edit
      @twitterer = Twitterer.find(params[:id])
    end

    # POST /twitterers
    # POST /twitterers.xml
    def create
      @twitterer = Twitterer.new(params[:twitterer])

      respond_to do |format|
        if @twitterer.save
          flash[:notice] = 'Twitterer was successfully created.'
          format.html { redirect_to(@twitterer) }
          format.xml  { render :xml => @twitterer, :status => :created, :location => @twitterer }
          format.json  { render :json => @twitterer, :status => :created, :location => @twitterer }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @twitterer.errors, :status => :unprocessable_entity }
          format.xml  { render :json => @twitterer.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /twitterers/1
    # PUT /twitterers/1.xml
    def update
      @twitterer = Twitterer.find(params[:id])
    
      respond_to do |format|
        if @twitterer.update_attributes(params[:twitterer])
          flash[:notice] = 'Twitterer was successfully updated.'
          format.html { redirect_to(@twitterer) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @twitterer.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /twitterers/1
    # DELETE /twitterers/1.xml
    def destroy
      @twitterer = Twitterer.find(params[:id])
      @twitterer.destroy

      respond_to do |format|
        format.html { redirect_to(twitterers_url) }
        format.xml  { head :ok }
        format.json  { head :ok }
      end
    end
  end
