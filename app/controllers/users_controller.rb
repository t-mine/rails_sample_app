class UsersController < ApplicationController

  #プロフィール画面を表示
  def show
    @user = User.find(params[:id])
  end

  #サインアップ画面を表示
  def new
    @user = User.new
  end

  #サインアップ
  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params
        .require(:user)
        .permit(
          :name, 
          :email, 
          :password, 
          :password_confirmation
        )
    end
end
