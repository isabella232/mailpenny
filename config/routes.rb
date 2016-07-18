Rails.application.routes.draw do
  get 'dashboard/overview'

  get 'dashboard/profile'

  get 'dashboard/account'

  get 'dashboard/billing'

  get 'dashboard/messages'

  # static pages are public pages
  root to: redirect('/home') # redirect root to /home
  get 'home'    => 'static_pages#home'
  get 'about'   => 'static_pages#about'
  get 'terms'   => 'static_pages#terms'
  get 'privacy' => 'static_pages#privacy'
  get 'help'    => 'static_pages#help'

  # user signups and registration
  devise_for :users
  as :user do
    get    'login'    => 'users/sessions#new', as: :login_page
    post   'login'    => 'users/sessions#create'
    delete 'logout'   => 'users/sessions#destroy'
    get    'register' => 'users/registrations#new', as: :register_page
  end
end
