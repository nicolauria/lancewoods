Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  
  post 'newsletter', to: 'static_pages#newsletter'

  get 'product', to: 'static_pages#product'

  post 'add_to_cart', to: 'static_pages#add_to_cart'
  get 'cart', to: 'static_pages#cart'
  post 'update_quantity', to: 'static_pages#update_quantity'
end
