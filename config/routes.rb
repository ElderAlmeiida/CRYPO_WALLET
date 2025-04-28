Rails.application.routes.draw do
  # Rota para a página de boas-vindas
  get "welcome/index"
  root to: "welcome#index"

  # Rotas para busca e detalhes de criptomoedas
  get "coins_search/search", to: "coins_search#search", as: :coins_search_search
  get "crypto/search", to: "coins_search#search", as: :crypto_search
  get "crypto/:id", to: "coins_search#details", as: :coin_details
  post "coins/import/:id", to: "coins#import", as: :import_coin
# Captura qualquer requisição para a pasta .well-known
get "/.well-known/*path", to: "application#handle_well_known", constraints: { path: /.*/ }

  # Recursos CRUD para coins + rotas adicionais de coleção
  resources :coins do
    collection do
      post :update_prices   # Atualizar preços (em todos)
      post :import          # Importar (usado no botão)
    end
  end

  # Recursos para CoinsSearchController (se tiver CRUD nele)
  resources :coins_search

  # Healthcheck
  get "up" => "rails/health#show", as: :rails_health_check
end
