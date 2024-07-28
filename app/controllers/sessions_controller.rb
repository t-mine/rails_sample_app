class SessionsController < ApplicationController
  #ログイン画面を表示
  def new
  end

  #ログイン処理
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
    else
      # エラーメッセージを作成する
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end
end
