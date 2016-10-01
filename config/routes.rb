Rails.application.routes.draw do
  mount Redactor2Rails::Engine => '/redactor2_rails'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy'
  end
  get 'join', to: 'users#join'

  namespace :admin do
    root to: "pages#home"
    get :staffs, to: "users#staffs"
    patch 'users/role', to: "users#role"
    resources :proposals
    resources :projects do
      resources :matches, shallow: true
    end
    resources :committees
    resources :congressmen
  end
  root 'pages#home'

  concern :commentable do
    resources :comments, shallow: true
  end
  concern :likable do
    resources :likes, shallow: true
  end

  resources :committees
  resources :congressmen
  resources :users
  get '/me', to: 'users#me', as: :current_user
  resources :proposals, concerns: [:commentable, :likable] do
    get :thanks, on: :member
  end
  resources :projects, concerns: [:commentable, :likable] do
    resources :participations do
      delete :cancel, on: :collection
    end
  end
  resources :questions, concerns: [:commentable, :likable]
  resources :comments, only: :index

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/devel/emails"
  end
  unless Rails.env.production?
    get 'kill_me', to: 'users#kill_me'
  end
end
