class SessionsController < ApplicationController
  # ログイン画面を表示
  def new
  end

  # ログイン処理
  def create
    # DBからユーザオブジェクトを生成
    user = User.find_by(email: params[:session][:email].downcase)
    # パスワードチェック
    if user&.authenticate(params[:session][:password])
      # セッションをリセットする（削除して再作成）
      # Railsのデフォルト設定ではセッションはCookieに暗号化＋Base64エンコードされて保存される
      # Cookieの有効期限はSession（ブラウザを閉じるまで）が設定される
      reset_session
      # セッションを永続化する
      remember user
      # ログインする（CookieのセッションにユーザIDを保存）
      log_in user
      # 生成したユーザオブジェクトを使用して、ユーザのプロフィール画面にリダイレクト
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
