# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users,
  :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout',
    :sign_up => 'signup'
  }

  resources :survey_responses
  resources :survey_questions
  resources :surveys
  resources :cohorts
  resources :projects
  resources :surveys, only: [:new] do
    resource :survey_questions, only: [:new]
  end

  root to: "static#home"
end
