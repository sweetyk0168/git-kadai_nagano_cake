Rails.application.routes.draw do
  #namespace :admin do
  #  get 'homes/top'
  #end
  # devise_for :customers
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

  root to: 'public/homes#top'
  get 'home/about' => 'public/homes#about', as: 'about'
  get 'customers/confirm_withdraw' => 'public/customers#confirm_withdraw'
  patch 'customers/confirm_withdraw' => 'public/customers#withdraw'
  get 'customers/information/edit' => 'public/customers#edit'
  patch '/customers/information' => 'public/customers#update'
  get 'customers/show' => 'public/customers#show'

namespace :admin do
    get 'homes/top' => "homes#top"
    resources :genres, only: [:index,:create,:edit,:update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :get_image, only: [:new, :index, :show]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index,:show, :update]
    #patch 'orders/index' => "orders#index"
    resources :order_details, only: [:update]
end

  #get 'customers/mypage' => 'customers#show'
  scope module: :public do
    resource :customers, only: [:show]
    resources :items, only: [:index, :show, :new]
    resources :cart_items, only: [:create, :index, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders, only:[:new, :index, :show, :create] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
