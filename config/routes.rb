Rails.application.routes.draw do
  resources :users
  post "users/:id/styles" => "users#measure"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
