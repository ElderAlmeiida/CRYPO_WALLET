Rails.application.routes.draw do
  # Rota para a página de index do welcome
  get "welcome/index"

  # Definir o root da aplicação
  root to: "welcome#index"

  # Rota de busca de criptomoedas no controlador CoinsSearchController
  get "coins_search/search", to: "coins_search#search", as: :coins_search_search
  get "crypto/search", to: "coins_search#search", as: :crypto_search
  get "crypto/:id", to: "coins_search#details", as: :coin_details
  post "coins/import/:id", to: "coins#import", as: :import_coin


  # Recursos para o controlador de moedas (CRUD)
  resources :coins


  # Rota para verificar o status da aplicação
  get "up" => "rails/health#show", as: :rails_health_check

  # Outras rotas específicas para PWA (Progressive Web App)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # A rota padrão (comentada, caso queira utilizar para outra página)
  # root "posts#index"
end
