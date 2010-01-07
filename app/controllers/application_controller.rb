# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'yaml'

class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  before_filter :ensure_domain

  def ensure_domain
    # render :text => request.env['HTTP_HOST']
    # render :text => request.env.inspect
    # return false
    
    unless RAILS_ENV=="development"
      the_domain  = 'devdiari.es'
      request_uri = request.env['REQUEST_URI']
    
      if request.env['HTTP_HOST']!=the_domain
        redirect_to "http://" + the_domain + request_uri
      end
    end
  end
  
  def cappuccino_404
    render :nothing => true
  end
  
  private
    def get_admins
    	users = {}

      if ENV['login'] && ENV['password']
        users[ENV['login']]=ENV['password']
      else
      	config = YAML.load_file("config/passwd.yml")
      	tmp_users = config["users"];
    	
      	tmp_users.each { |user, password|
      	  users[user] = password["password"]
      	}
      end

    	return users
    end
    
    def digest_authenticate
      users = get_admins
      authenticate_or_request_with_http_basic do |username, password|
        !users[username].nil? && users[username]==password
      end
    end
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
