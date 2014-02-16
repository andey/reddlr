Reddlr::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts do
    member do
      get 'comments'
      get 'removal'
      get 'pay'
      get 'execute'
    end
    collection do
      get 'complete'
    end
  end
  resources :subreddits do
    member do
      get 'stylesheet'
      get 'javascript'
    end
  end
  root 'subreddits#index'
end
