class HomeController < ApplicationController
  def welcome
  end

  def get_interest_categories
  	@interest_categories = Interest.where(category_id: nil) 
  end

  def get_interests_of_category
  	@interests = Interest.where(category_id: params[:interest_category_id])
  end

  def get_interests_of_current_user
  	@interests = current_user.interests
  end

  def edit_user_interests_only_for_current_user
    if current_user

      if params[:user_interests]

        param_interests = []

        # transform the params into integers so they can be compared to the ids
        params[:user_interests].each do |i|
          if Interest.exists?(id: i.to_i)
            param_interests << i.to_i
          end
        end

        # get current user_interests
        current_user_interest_ids = current_user.interests.pluck(:id)

        # the ids in params list that are not in current list need to be added
        interests_to_add = param_interests - current_user_interest_ids

        if interests_to_add.count > 0
          interests_to_add.each do |interest_id|
            UserInterest.create(user_id: current_user.id, interest_id: interest_id)
          end
        end

        # the ids in current list that are not in params list need to be deleted from user_interests
        interests_to_delete = current_user_interest_ids - param_interests

        if interests_to_delete.count > 0
          interests_to_delete.each do |interest_id|
            u = UserInterest.where(user_id: current_user.id, interest_id: interest_id)
            if u
              u.first.destroy
            end
          end
        end

        respond_to do |format|
          format.json { render :json => {:success=>true, :message=>"UserInterests were successfully updated."} }
        end
      else
        respond_to do |format|
          format.json { render :json => {:success=>false, :message=>"No user interests detected."} }
        end
      end # end of if params

    else

      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"Something's wrong with the auth_token. Current_user is nil."} }
      end

    end # end of current user
  end

end
