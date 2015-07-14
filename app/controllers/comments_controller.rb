class CommentsController < ApplicationController
  before_action :authenticate
  before_action :set_comment, only: [:show, :destroy]

  def index
  	if params[:activity_id]
  		if Goingtoactivity.where(user_id: current_user.id, activity_id: params[:activity_id]).count >= 1
	  		@comments = Comment.where(activity_id: params[:activity_id])
	  	else
	  		respond_to do |format|
		    	format.json { render :json => {:success=>false, :message=>"You're not going to this activity so you can't see its comments."} }
		    end
	  	end
  	else
  		respond_to do |format|
        	format.json { render :json => {:success=>false, :message=>"There is no activity id in params."} }
      	end
  	end
  end

  def show
  end

  def new
  	@comment = Comment.new
  end

  def create
  	if current_user
  		if Goingtoactivity.where(user_id: current_user.id, activity_id: comment_params[:activity_id]).count >= 1

	      @comment = Comment.new(comment_params)
	      @comment.user_id = current_user.id

	      respond_to do |format|
	        if @comment.save
	          format.json { render :show, status: :created, location: @comment }
	        else
	          format.json { render json: @comment.errors, status: :unprocessable_entity }
	        end
	      end

	    else
	    	respond_to do |format|
		    	format.json { render :json => {:success=>false, :message=>"You're not going to this activity so you can't post comments."} }
		    end
	    end
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"Something's wrong with the token. current_user is nil."} }
      end
    end
  end

  def destroy
  	# only the owner can destroy his / her activity
    if current_user.id == @comment.user_id
      @comment.destroy
      respond_to do |format|
        format.json { render :json => {:success=>true, :message=>"Comment was successfully destroyed."} }
      end
    else
      respond_to do |format|
        format.json { render :json => {:success=>false, :message=>"You are not the owner of this comment."} }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :activity_id, :content)
    end
end
