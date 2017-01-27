Rails.application.routes.draw do
  resources :posts, :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
