Rails.application.routes.draw do
  # Sessões e registros
  resource :session, only: [:new, :create, :destroy]
  resource :registration, only: [:new, :create]

  # Listas e Tarefas
  resources :lists do
    resources :tasks, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :tasks, only: [:destroy]  # Tarefa independente para exclusão
  

  # Dashboard
  get "dashboard", to: "home#dashboard", as: :dashboard

  # Health Check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Rota raiz
  root "home#index"
end
