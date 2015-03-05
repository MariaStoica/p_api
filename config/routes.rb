PenginApi::Application.routes.draw do

	get    'signup'  => 'users#new'
	get    'login'   => 'sessions#new'
	post   'login'   => 'sessions#create'
	delete 'logout'  => 'sessions#destroy'

	resources :api_keys
	resources :users

	root to: "home#welcome"

end
