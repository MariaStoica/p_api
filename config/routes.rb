PenginApi::Application.routes.draw do

  # get 'comments/index'

  # get 'comments/new'

  # get 'comments/create'

  # get 'comments/destroy'

	get    'signup'  => 'users#new'
	get    'login'   => 'sessions#new'
	post   'login'   => 'sessions#create'
	delete 'logout'  => 'sessions#destroy'

	get 'interest_categories' => 'home#get_interest_categories'
	get 'interests_of_category' => 'home#get_interests_of_category'
	get 'my_interests' => 'home#get_interests_of_current_user'
	post 'edit_my_interests' => 'home#edit_user_interests_only_for_current_user'
	get 'my_activities' => 'home#get_my_activities'
	get 'my_feed' => 'home#get_my_feed'
	post 'request_sms' => 'users#request_sms_for_login'

	resources :api_keys
	resources :users
    resources :user_interests
    resources :interests
    resources :activities
    resources :goingtoactivities
    resources :comments

	root to: "home#welcome"

end
