class TweetsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}

  def index
  	@tweets = Tweet.all.order(created_at: :desc)
  end

  def show
  	@tweet = Tweet.find_by(id: params[:id])
    @user = @tweet.user
  end

  def edit
  	@tweet = Tweet.find_by(id: params[:id])
  end

  def new
  	@tweet = Tweet.new
  end

  def create
  	@tweet = Tweet.new(
      body: params[:body],
      user_id: @current_user.id
      )
    if @tweet.save
    	flash[:notice] = "投稿しました"
  		redirect_to ("/tweets")
    else
    	render ("/tweets/new")
    end
  end

  def update
  	@tweet = Tweet.find_by(id: params[:id])
    @tweet.body = params[:body]
    if @tweet.save
    	flash[:notice] = "投稿を編集しました"
  		redirect_to ("/tweets")
  	else
  		render("tweets/edit")
  	end
  end

  def destroy
  	@tweet = Tweet.find_by(id: params[:id])
    @tweet.destroy
    flash[:notice] = "投稿を削除しました"
  	redirect_to ("/tweets")
  end

  def ensure_correct_user
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
