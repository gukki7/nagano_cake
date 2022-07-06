Rails.application.routes.draw do
  devise_for :customers
  namespace :admin do
    root to: 'homes#top'
    #resources :sessions, only: [:new, :create, :destroy]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  namespace :public do
    root to: 'homes#top'
    get 'home/about' => 'homes#about'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    get 'customers/withdraw' => 'customers#withdraw'
    get 'cart_items/destroy_all' => 'cart_items/destroy_all'
    get 'orders/comfirm' => 'orders/comfirm'
    get 'orders/complete' => 'orders/complete'
    resources :items, only: [:index, :show,]
   # resources :registrations, only: [:new, :create]
   # resources :sessions, only: [:new, :create, :destroy]
    resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :orders, only: [:index, :new, :create, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
