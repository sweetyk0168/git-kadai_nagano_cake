Rails.application.routes.draw do
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  namespace :admin do
  resources :genres,only: [:index,:create,:edit,:update]
  resources :items,only: [:index, :new, :create, :show, :edit, :update]
  end
# 顧客用
# URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

# 管理用
# URL /admin/sign_in ...
  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
