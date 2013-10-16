PureNotifier::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/:provider/errback', to: 'sessions#fail'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :subscriptions, only: [:index, :create, :destroy]

  authenticate do
    mount Resque::Server, :at => "/admin/resque"
  end
end
