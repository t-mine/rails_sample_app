Rails.application.routes.draw do
  root "static_pages#home"
  #"static_pages#help"はコントローラとアクションを指定している
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get  "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  # 以下の標準的なルーティングを自動で設定。。
  # GET /users => UsersController#index # ユーザー一覧表示
  # GET /users/new => UsersController#new # 新しいユーザー作成フォーム
  # POST /users => UsersController#create # ユーザーの作成
  # GET /users/:id => UsersController#show # 特定ユーザーの詳細表示
  # GET /users/:id/edit => UsersController#edit # 特定ユーザーの編集フォーム
  # PATCH/PUT /users/:id => UsersController#update # ユーザーの更新
  resources :users
end
