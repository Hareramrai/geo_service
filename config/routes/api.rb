namespace :api, defaults: { format: "json" } do
  resources :users, only: %I[index]
end