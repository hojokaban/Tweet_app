class UsersController < ApplicationController

  # ログインしていない時は入れない
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  # ログインしている時に入れなくなる
  before_action :forbid_login_user,{only: [:new, :create, :login_form, :login]}
  # urlを打っても入れなくする
  before_action :ensure_correct_user,{only: [:edit, :update]}

  def index
  	@users = User.all
  end

  def show
  	@user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    # 画像を更新する時は画像名をuser.idに変更してpublic/user_imeagesに保存する
    if params[:image]
      image = params[:image]
      @user.icon_id = "#{@user.id}.jpg"
      File.binwrite("public/user_images/#{@user.icon_id}",image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to ("/users/#{@user.id}")
    else
      render ("/users/edit")
    end
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      icon_id: "no_image.jpg"
      )
  	if @user.save
      session[:user_id] = @user.id
  		flash[:notice] = "ユーザー登録が完了しました"
		redirect_to ("/users/#{@user.id}")
	 else
		render ("/users/new")
	 end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
    end
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to ("/tweets")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      render ("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to ("/login")
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
    flash[:notice] = "権限がありません"
    redirect_to("/tweets")
    end
  end
end
