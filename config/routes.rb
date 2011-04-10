FullStackIntegrationTesting::Application.routes.draw do
  get '/calculator' => 'calculator#index', :as => 'calculator'
  put '/calculator' => 'calculator#calculate', :as => 'calculate_calculator'
  get '/javascript_test/:script' => 'javascript_test#render_test'
  root :to => "pages#home"
end
