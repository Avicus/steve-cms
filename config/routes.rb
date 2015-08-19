SteveCms::Application.routes.draw do
  root 'admin/main#index'

  namespace :admin do
    get '' => 'main#index'

    scope 'users' do
      get '' => 'users#index'
    end

    get '*unmatched_route' => 'main#not_found'
  end

  scope '' do
    get 'login' => 'sessions#login'
    post 'logout' => 'sessions#logout'
  end

  # match '*path' => 'client#route', :via => :all
end
