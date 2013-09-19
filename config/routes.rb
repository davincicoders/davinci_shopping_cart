DavinciShoppingCart::Application.routes.draw do
  post 'line_items' => 'line_items#create'

  get 'store' => 'store#index'

  get 'my_cart' => 'store#my_cart', as: 'cart'
  delete 'my_cart' => 'store#empty_cart'

  resources :products

  root to: 'store#index'
end