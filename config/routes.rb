DavinciShoppingCart::Application.routes.draw do
  resources :orders, except: [:edit, :update]

  post 'line_items' => 'line_items#create'

  get 'store' => 'store#index'

  delete 'my_cart' => 'store#empty_cart', as: 'cart'

  resources :products

  root to: 'store#index'
end