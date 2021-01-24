Rails.application.routes.draw do
  resources :survey_responses
  resources :survey_questions
  resources :surveys
  resources :cohorts
  resources :projects
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
