require 'api_constraints'
Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
      scope module: :v1 do
      	resources :users, only: [:show, :create, :update, :destroy, :index]
      	resources :sessions, :only => [:create, :destroy]
      end
  end

end