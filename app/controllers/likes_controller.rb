class LikesController < ApplicationController

  before_action :authenticate_user

  def create
  	@like = Like.new(
      user_id: @current_user.id,
      tweet_id: params[:tweet_id]
      )
    @like.save
    redirect_to ("/tweets/#{params[:tweet_id]}")
  end

  def destroy
  	@like = Like.find_by(
  		user_id: @current_user.id,
      tweet_id: params[:tweet_id]
  		)
  	@like.destroy
  	redirect_to ("/tweets/#{params[:tweet_id]}")
  end

end