Rails.application.routes.draw do
  resources :clients do
    resources :invoices do
      resources :fees, only: [:index, :create]
      member do
        patch :update_status
      end
    end
  end
end