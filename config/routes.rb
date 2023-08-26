Rails.application.routes.draw do
  root to: 'public/homes#top'
  get 'home/about' => 'public/homes#about', as: 'about'
  namespace :customers do
    resources :customers,only: [:show, :edit, :update]
    get 'mypage' => 'public/customers#show'
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
