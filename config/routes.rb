Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: 'projects#index'

  resources :projects do
    resources :categories, except: %i[index show]
  end
end
