class WelcomeController < ApplicationController

  def index
  	# @controller_message = "Decode this message from controller"
  end

  def async
    Worker.perform_async("easy")
    render plain: 'Workers will execute the corresponding jobs'
  end

  
end

	
	  	
