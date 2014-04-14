MyBlog::Application.routes.draw do
  
  devise_for :users
  resources :posts
  resources :comments
  root to: 'posts#index'

end
