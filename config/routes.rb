# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :courses
      resources :competences
      resources :users, only: [:destroy]
    end
  end
end
