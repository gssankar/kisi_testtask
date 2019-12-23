Rails.application.routes.draw do
  root 'welcome#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  get '/hello/:name', to: 'hello#say'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
