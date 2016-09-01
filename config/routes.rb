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

  resources :proposals, concerns: :commentable
  resources :questions, concerns: :commentable

  root 'pages#home'
end
