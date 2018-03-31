Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  resources :notes

  authenticated :user do
  	#we can not have two roots in route hence rename it
  	root 'notes#index', as: "authenticated_root"
  end

  get '/notes/hashtag/:name', to: 'notes#hashtags'

  root 'welcome#index'

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
