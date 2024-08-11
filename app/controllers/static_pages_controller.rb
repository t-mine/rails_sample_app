# アクションの中で特に何も指定しなければ、
# アクション名と同じ名前のテンプレートが自動的にレンダリングされる
class StaticPagesController < ApplicationController

  # routes.rbの「root "static_pages#home"」でURLを設定してる
  def home
    # app/views/static_pages/home.html.erbが表示される
  end

  # routes.rbの「 get  "/help",    to: "static_pages#help"」でURLを設定してる
  def help
  end

  # routes.rbの「get  "/about",   to: "static_pages#about"」でURLを設定してる
  def about
  end

  # routes.rbの「get  "/contact", to: "static_pages#contact"」でURLを設定してる
  def contact
  end
end
