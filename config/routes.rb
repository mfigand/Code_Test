Rails.application.routes.draw do

  root to: "site#home"

  get '/banks', to: 'banks#new'

  get '/banks/:bank_id/inter_transfers/new', to: 'transfers#new_inter_transfers', as: 'new_bank_InterTransfer'


  resources :banks do
    resources :accounts, :transfers
  end
end
