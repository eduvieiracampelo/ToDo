Rails.application.routes.draw do
  get "projects/index"
  get "projects/show"
  get "projects/new"
  get "projects/create"
  get "projects/edit"
  get "projects/update"
  get "projects/destroy"
  get "up" => "rails/health#show", as: :rails_health_check

  root "projects#index"

  resources :projects do
    resources :tasks, only: [ :new, :create, :edit, :update, :destroy ]
  end

  patch "/tasks/:id/status", to: "tasks#update_status", as: :update_task_status
end
