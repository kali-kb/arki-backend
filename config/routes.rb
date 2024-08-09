Rails.application.routes.draw do
  # resources :users do
  #   resources :jobs
  #   resources :saved_jobs
  # end
  # resources :companies
  # resources :private_clients
  # # resources :jobs
  # resources :job_applications

  resources :users do
    resources :jobs do
      resources :job_applications, only: [:create, :index, :destroy]
    end
    resources :job_applications, only: [:create, :index]
    resources :saved_jobs
  end
  resources :companies
  resources :private_clients
  resources :jobs, only: [:index, :show]
  resources :job_applications

  # get "job_search", to: "job#job_query"


    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
