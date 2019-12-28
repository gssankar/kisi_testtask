require 'sidekiq'

class Worker
	include Sidekiq::Worker

	# If a job fails, it should be retried at most two times at least five minutes apart
	# 3 tries in total 
	sidekiq_options :queue => :default, retry: 0
	sidekiq_retry_in do |count|
		300
	end

	# If the second retry fails, enqueue the job to a morgue queue 
	# q_from = "default"
	# q_to = "morgue"
	# count_block = proc { Sidekiq.redis do |conn|
	# 	conn.llen("queue:#{q_from}")
	# 	end }

	# while count_block.call > 0 
	# 	Sidekiq.redis do |conn| 
	# 		conn.rpoplpush "queue:#{q_from}", "queue:#{q_to}" 
	# 	end
	# end

	def perform(complexity) 
		case complexity 
		when "hard" 
			sleep 10 
			puts "Really took a quite bit of effort"
		when "easy"
			sleep 1
			puts "That wasn't a lot of effort"
		else
			raise "Invalid Value"
		end
	end
end





