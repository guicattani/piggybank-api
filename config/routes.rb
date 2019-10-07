# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' },path: '/' do
    namespace :v1, constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update, :destroy]
    end
  end
end
