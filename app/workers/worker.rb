require 'sidekiq'

class Worker
	include Sidekiq::Worker

	# 3. If a job fails, it should be retried at most two times at least five minutes apart (three tries in total, morgue queue)
	sidekiq_options :queue => :default, retry: 2
	sidekiq_retry_in do |count|
		300
	end

	# 2. Background workers dequeue job params and execute the corresponding jobs
	def perform(params) 
		case params 
		when "pull"
			sleep 1
			puts "Message being pulled from Google Cloud Pub/Sub"
			fork { exec("gcloud pubsub subscriptions pull --auto-ack kisi_pro1") } # Check the subscription
		else
			raise "Invalid Value"
		end
	end

end
