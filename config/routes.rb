Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy'
  end

  concern :commentable do
    resources :comments, shallow: true
  end
  concern :likable do
    resources :likes, shallow: true
  end

  resources :committees
  resources :congressmen
  resources :users
  resources :proposals, concerns: [:commentable, :likable]
  resources :projects, concerns: [:commentable, :likable]
  resources :questions, concerns: [:commentable, :likable]

  root 'pages#home'
end
