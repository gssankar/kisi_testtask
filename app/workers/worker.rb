# We require sidekiq, obviously.
require 'sidekiq'

# # We'll configure the Sidekiq client to connect to Redis using a custom
# # DB - this way we can run multiple apps on the same Redis without them
# # stepping on each other

# Sidekiq.configure_client do |config|
#   config.redis = { db: 1 }
# end

# # We'll  configure the Sidekiq server as well

# Sidekiq.configure_server do |config|
#   config.redis = { db: 1 }
# end

# # ---------------------------------------------


class Worker
	include Sidekiq::Worker
	# sidekiq_options retry: false
	sidekiq_options retry: 2 # Only two retries and then to the Dead Job Queue

	def perform(complexity) 
		case complexity 
		when "super_hard" 
			sleep 10 
			puts "Really took a quite bit of effort"
		when "hard"
			sleep 5
			puts "That was a bit of work"
		when
			sleep 1 
			puts "That wasn't a lot of effort"
		else 
			sleep 1
			puts "Not in worker schema"
		end
	end
end


