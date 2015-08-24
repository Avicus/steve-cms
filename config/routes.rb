SteveCms::Application.routes.draw do

  namespace :admin do
    get '' => 'main#index', :as => ''

    scope 'users' do
      get '' => 'users#index', :as => 'users'
      post 'search' => 'users#search', :as => 'users_search'
    end

    scope 'settings' do
      get '' => 'settings#index', :as => 'settings'
      post '' => 'settings#index'
    end

    get '*unmatched_route' => 'main#not_found'
  end

  scope '' do
    get 'password_reset' => 'admin/sessions#reset'
    post 'password_reset' => 'admin/sessions#reset'
    get 'login' => 'admin/sessions#login'
    post 'login' => 'admin/sessions#login'
    get 'logout' => 'admin/sessions#logout'
    get 'register' => 'admin/sessions#register'
    post 'register' => 'admin/sessions#register'
  end

  root 'client#route'
  match '*path' => 'client#route', :via => :all
end
