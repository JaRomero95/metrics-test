# frozen_string_literal: true

Rails.application.routes.draw do
  resources :group_metrics, only: :index
  resources :metrics, only: :create
end
