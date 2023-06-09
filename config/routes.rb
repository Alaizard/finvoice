Rails.application.routes.draw do
  resources :clients, only: [ :index, :create, :show ] do
    resources :invoices, only: [ :create, :update, :show ] do
      post '/close_invoice', to: "invoices#close_invoice"
    end
  end
end