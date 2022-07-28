Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  namespace :public do
    root to: 'homes#top'
    get 'home/about' => 'homes#about'
    get 'customers/my_page' => 'customers#show'
    get 'customers/infomation/edit' => 'customers#edit'
    #patch 'customers/infomation' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    #patch 'customers/withdraw' => 'customers#withdraw'
    #delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    post 'orders/comfirm' => 'orders#comfirm'
    get 'orders/complete' => 'orders#complete'
    resources :items, only: [:index, :show,]
    #resource :customers, only: [:edit, :update]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :orders, only: [:index, :new, :create, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
