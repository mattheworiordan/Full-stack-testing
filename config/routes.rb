FullStackIntegrationTesting::Application.routes.draw do
  get '/calculator' => 'calculator#index', :as => 'calculator'
  put '/calculator' => 'calculator#calculate', :as => 'calculate_calculator'
  root :to => "pages#home"
end
