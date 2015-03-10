PenginApi::Application.routes.draw do

	get    'signup'  => 'users#new'
	get    'login'   => 'sessions#new'
	post   'login'   => 'sessions#create'
	delete 'logout'  => 'sessions#destroy'

	get 'interest_categories' => 'home#get_interest_categories'
	get 'interests_of_category' => 'home#get_interests_of_category'
	get 'my_interests' => 'home#get_interests_of_current_user'

	resources :api_keys
	resources :users
    resources :user_interests
    resources :interests

	root to: "home#welcome"

end
