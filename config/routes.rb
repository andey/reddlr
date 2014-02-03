Reddlr::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts do
    member do
      get 'comments'
    end
  end
  root to: 'admin/dashboard#index'
end
