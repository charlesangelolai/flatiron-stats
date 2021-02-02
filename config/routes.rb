# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :comments
  resources :replies
  resources :posts
  resources :categories
  devise_for :users,
  :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout',
    :sign_up => 'signup'
  }

  devise_scope :user do
    authenticated :user do
      root 'dashboard#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :cohorts
  resources :surveys
  resources :survey_responses
  resources :survey_questions
  
  resources :projects, except: [:show]
  resources :projects, only: [:show] do
    resource :survey_responses
  end

  resources :categories, except: [:show]
  resources :categories, only: [:show] do
    resources :posts do
      resources :comments
    end
  end

  get '/dashboard', to: 'dashboard#index'
  get '/account/:id', to: 'users#show', as: 'account'

  # root to: 'static#home'
end
