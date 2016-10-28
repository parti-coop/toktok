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
    get 'download_emails', to: 'base#download_emails'
    patch 'users/role', to: "users#role"
    resources :proposals
    resources :projects do
      resources :matches, shallow: true
      resources :timelines, shallow: true do
        member do
          delete :remove_image
        end
      end
    end
    resources :committees
    resources :congressmen
  end
  root 'pages#home'
  get '/user_agreement', to: "pages#user_agreement", as: 'user_agreement'
  get '/privacy', to: "pages#privacy", as: 'privacy'

  concern :commentable do
    resources :comments, shallow: true
  end

  concern :likable do
    resources :likes, shallow: true do
      delete :destroy, on: :collection
    end
  end

  resources :committees
  resources :congressmen
  resources :users
  get '/current_password/edit', to: 'users#edit_current_password', as: :edit_current_password
  patch '/current_password', to: 'users#update_current_password', as: :current_password
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
  resources :comments, concerns: [:likable]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/devel/emails"
  end
  unless Rails.env.production?
    get 'kill_me', to: 'users#kill_me'
  end
end
