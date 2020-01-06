Rails.application.routes.draw do

	root 'welcome#index'

	get 'welcome', to: 'welcome#subscription'
	get 'welcome/publish_message', to: 'welcome#publish_message'
	get 'welcome/start_worker', to: 'welcome#start_worker'

	get '/hello/:name', to: 'hello#say'

	require 'sidekiq/web'
	mount Sidekiq::Web => "/sidekiq"
	
end
