Rails.application.routes.draw do

  resources :services
  resources :classrooms
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations' }

  resources :users, only: [:index, :show, :destroy, :edit, :update] do
    member do
      patch :ban
      patch :resend_confirmation_instructions
      patch :resend_invitation
    end
  end

  resources :courses do
    resources :lessons, controller: "courses/lessons"
    member do
      patch :generate_lessons
    end
  end
  
  root "static_pages#landing_page"
  # get 'static_pages/landing_page'
  # get 'static_pages/privacy_policy'
  get "privacy_policy", to: "static_pages#privacy_policy"
  get "calendar", to: "static_pages#calendar"
end