Rails.application.routes.draw do

  resources :wikis  do
    resources :collaborators, only: [:create, :destroy]
  end

  resources :charges, only: [:new, :create]

  devise_scope :user do
    put 'users/downgrade' => 'users/registrations#downgrade'
  end

  devise_for :users

  get 'about' => 'welcome#about'

  get 'downgrade' => 'welcome#downgrade'

  root 'welcome#index'

end
