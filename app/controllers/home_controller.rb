class HomeController < ApplicationController
  def welcome
  end

  def get_interest_categories
  	@interest_categories = Interest.where(category_id: nil) 
  end

  def get_interests_of_category
  	@interests = Interest.where(category_id: params[:interest_category_id])
  end

end
