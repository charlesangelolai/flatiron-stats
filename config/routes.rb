# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users,
  :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout',
    :sign_up => 'signup'
  }

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :survey_responses
  resources :survey_questions
  resources :surveys
  resources :cohorts
  resources :projects
  resources :projects, only: [:show] do
    resource :survey_responses
  end

  get '/dashboard', to: 'dashboard#index'
  get '/account/:id', to: 'users#show', as: 'account'

  # root to: 'static#home'
end
