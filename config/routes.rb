# config/routes.rb
# frozen_string_literal: true

Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Ресурсный роутинг для постов
  resources :posts do
    # Комментарии - вложенный ресурс
    resources :comments, only: %i[create destroy]

    # Лайки - вложенный ресурс (так как они принадлежат посту)
    resources :likes, only: %i[create destroy]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
end
