Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "projects#index"

  resources :projects do
    resources :tasks, only: [ :new, :create, :show, :edit, :update, :destroy ]
  end

  patch "/tasks/:id/status", to: "tasks#update_status", as: :update_task_status
end
