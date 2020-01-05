class WelcomeController < ApplicationController

  def index
  	# @controller_message = "Decode this message from controller"
  end


  def publishmessage
  	fork { exec ("bundle exec ruby app.rb") }
    # sleep 3
  	# flash[:success] = "Published Message"
    redirect_to :root #redirect_to "localhost:4567"
  end


  def subscription 
  	fork{exec("redis-server")}
  	sleep 2

    #Creating a subscription for the topic kisi_product
  	fork { exec("gcloud pubsub subscriptions create kisi_basic1 --topic kisi_product") }

  	# if 
  	flash[:success] = "Subscription Created"
  	redirect_to :root

    # 1. Transparent enqueueing with ActiveJob to Google Pub Sub
  	Worker.perform_async("invalid") # Also pass in "easy" or "hard"
  end


  def startworker
  	fork { exec("bundle exec sidekiq") }
  	sleep 2
  	flash[:success] = "Sidekiq Worker Started "
  	redirect_to :root
  end


end