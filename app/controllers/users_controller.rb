class UsersController < ApplicationController

  # プロフィール画面を表示
  # ※routes.rbのresources :usersという指定により、
  #  「GET /users/:id => UsersController#show」というルーティングが有効になっている
  def show
    #@をつけてインスタンス変数にすることでビューからの参照が可能になる
    @user = User.find(params[:id])
  end

  #サインアップ画面を表示
  # ※routes.rbのresources :usersという指定により、
  #  「POST /users => UsersController#create」というルーティングが有効になっている
  def new
    #@をつけてインスタンス変数にすることでビューからの参照が可能になる
    @user = User.new
  end

  #サインアップ
  def create
    @user = User.new(user_params) # user_paramsはメソッド。Strong Parametersという機能を使用している
    # saveはActiveRecordの標準メソッド。Upsertしている。保存が成功するとtrue、失敗するとfalseを返す
    if @user.save
      reset_session
      # Cookie(セッション)にユーザIDを保存
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      # バリデーションエラー、DB制約違反、不正なデータ型や形式
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
