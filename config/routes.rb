Rails.application.routes.draw do

  resources :relays do
    resources :relay_destinations
    resources :relay_logs, shallow: true, only: %w[index show]
  end
  match 'relays/:id/exec/*paths', to: 'relay_exec#exec', via: :all

  root 'relays#index'

  mount ActionCable.server => '/cable'
end
