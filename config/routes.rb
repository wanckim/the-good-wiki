Rails.application.routes.draw do

  resources :wikis
  resources :charges, only: [:new, :create]

  devise_scope :user do
    put 'users/downgrade' => 'users/registrations#downgrade'
  end

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registraions: 'users/registrations',
    sessions: 'users/sessions',
  }

  get 'about' => 'welcome#about'

  get 'downgrade' => 'welcome#downgrade'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
