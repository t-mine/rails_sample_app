module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    # セッションリプレイ攻撃から保護する
    # 詳しくは https://techracho.bpsinc.jp/hachi8833/2023_06_02/130443 を参照
    session[:session_token] = user.session_token
  end

  # 永続的セッションのためにユーザーをデータベースに記憶する
  #   ユーザIDと記憶トークンをCookieに保存して、それをキーにDBと照合してセッションを復活させる仕組みっぽい
  def remember(user)
    #ユーザテーブルのremember_digest列をハッシュ化した記憶トークンで更新
    user.remember
    #クッキーに暗号化したユーザIDを保存　※permanentでCookieの有効期限を20年後に設定
    cookies.permanent.encrypted[:user_id] = user.id
    #クッキーにハッシュ化していない記憶トークンを暗号化せずに保存　※permanentでCookieの有効期限を20年後に設定
    cookies.permanent[:remember_token] = user.remember_token
  end

  # セッションのuser_id、または、永続化したuser_id(有効期限が20年後のCookie)に対応するユーザーを返す
  def current_user

    if (user_id = session[:user_id])
      # セッションのuser_idに対応するユーザをDBから取得して返却。
      # @current_userに値を持つ場合はDB検索をスキップ(キャッシュ)
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.remember_digest
        @current_user = user
      end
    # 永続化したユーザIDと記憶トークンが正しければユーザを返す
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil   # 安全のため
  end
end
