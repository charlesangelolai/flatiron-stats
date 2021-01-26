Rails.application.routes.draw do
  devise_for :users
  resources :survey_responses
  resources :survey_questions
  resources :surveys
  resources :cohorts
  resources :projects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
