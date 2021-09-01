Rails.application.routes.draw do
  root to: 'app#index'
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :lunches, only: %i[show index create update destroy]
      resources :schedule_lunches, only: %i[show index create update destroy]
    end
  end
end
