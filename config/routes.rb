Rails.application.routes.draw do
  root :to => 'assets#index'
  get 'assets/index'
end
