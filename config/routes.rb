PenginApi::Application.routes.draw do

  resources :user_interests

  resources :interests

	get    'signup'  => 'users#new'
	get    'login'   => 'sessions#new'
	post   'login'   => 'sessions#create'
	delete 'logout'  => 'sessions#destroy'

	get 'interest_categories' => 'home#get_interest_categories'
	get 'interest_of_category' => 'home#get_interests_of_category'

	resources :api_keys
	resources :users

	root to: "home#welcome"

end
