Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  
  post 'newsletter', to: 'static_pages#newsletter'

  get 'product', to: 'static_pages#product'

  get 'shop', to: 'static_pages#shop'
  post 'add_to_cart', to: 'static_pages#add_to_cart'
  get 'cart', to: 'static_pages#cart'
  post 'update_quantity', to: 'static_pages#update_quantity'
  get 'checkout_page', to: 'static_pages#checkout_page'
  post 'checkout', to: 'static_pages#checkout'
  # for page refresh on cart page
  get 'checkout', to: 'static_pages#checkout_page'

  get 'blog', to: 'static_pages#blog'
  get 'blog_post', to: 'static_pages#blog_post'

  get 'contact', to: 'static_pages#contact'
  post 'contact', to: 'static_pages#contact_submit'

  get 'dashboard', to: 'dashboard#index'

  get 'edit_event', to: 'dashboard#edit_event_form'
  post 'edit_event', to: 'dashboard#edit_event'
  post 'delete_event', to: 'dashboard#delete_event'
  get 'add_event', to: 'dashboard#add_event_form'
  post 'add_event', to: 'dashboard#add_event'

  get 'edit_product', to: 'dashboard#edit_product_form'
  post 'edit_product', to: 'dashboard#edit_product'
  post 'delete_product', to: 'dashboard#delete_product'
  get 'add_product', to: 'dashboard#add_product_form'
  post 'add_product', to: 'dashboard#add_product'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
end
