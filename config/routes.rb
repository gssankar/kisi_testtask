Rails.application.routes.draw do

	root 'welcome#index'

	get 'welcome', to: 'welcome#async'
	get '/hello/:name', to: 'hello#say'
	# match ':controller(/:action(/:id))', :via => :get 

	# require "google/cloud/pubsub"

	require 'sidekiq/web'
	mount Sidekiq::Web => "/sidekiq"
end
