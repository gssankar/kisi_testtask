class WelcomeController < ApplicationController

  def index
  	# @controller_message = "Decode this message from controller"
  end


  def publishmessage
  	# fork { exec ("bundle exec ruby app.rb -p 8080") }
  	# render plain: 'Testing flash messages'
  	flash[:success] = "Message successfully tested"
  	redirect_to :root
  end


  def subscription
  	#Creates a new subscription
  	fork{exec("redis-server")}
  	sleep 2

  	fork { exec("gcloud pubsub subscriptions create kisi_basic1 --topic kisi_product") }
  	# if 
  	flash[:success] = "Subscription Created"
  	redirect_to :root

  	Worker.perform_async("easy")
  end


  def startworker
  	fork { exec("bundle exec sidekiq") }
  	sleep 2
  	flash[:success] = "Sidekiq Worker Started "
  	redirect_to :root
  end


end