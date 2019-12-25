Rails.application.routes.draw do
  
  root 'welcome#index'
  get 'job' => "welcome#job"
  get '/hello/:name', to: 'hello#say'


  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
    
end
