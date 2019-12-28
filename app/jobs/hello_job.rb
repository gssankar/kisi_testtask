class HelloJob < ApplicationJob
  queue_as :default

  def perform(name)
    puts "Hello, #{name} from ActiveJob!"
  end
  
end

