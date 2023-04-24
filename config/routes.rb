Rails.application.routes.draw do
  resources :clients, only: [ :index, :create, :show ] do
    resources :invoices, only: [ :create, :update, :show ] do
      post '/close', to: "invoices#close_invoice"
    end
  end
end