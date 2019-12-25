class WelcomeController < ApplicationController

  def index
  end

  def job
  	Worker.perform_async("oops")
  	render plain: 'Workers will execute the corresponding jobs'
  end

  # def notify 
  # 	NotifyEmailJob.perform_later(@user)
  # 	render plain: 'This job has been moved to Morgue Queue'
  # end

end



# Each action in the controller should have one of two forms: Read-type operations, CUD-type operations. 

