class WelcomeController < ApplicationController

  def index
  end


  def publish_message
  	fork { exec ("bundle exec ruby app.rb") }
  
    redirect_to :root #redirect_to "localhost:4567"
    flash[:success] = "Open localhost:4567 in a new tab"
  end


  def subscription 
  	fork{exec("redis-server")}
  	sleep 2

    #Creating a subscription for the topic kisi_product
  	fork { exec("gcloud pubsub subscriptions create kisi_pro1 --topic kisi_product") }

  	flash[:success] = "Subscription Created"
  	redirect_to :root

    # 1. Transparent enqueueing with ActiveJob to Google Pub Sub
  	Worker.perform_async("pull") # Pass an invalid argument to trigger the retry mechanism
  end


  def start_worker
  	fork { exec("bundle exec sidekiq") }
  	sleep 2
  	flash[:success] = "Sidekiq Worker Started "
  	redirect_to :root
  end


end