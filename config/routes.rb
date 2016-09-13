Rails.application.routes.draw do
  resources :social_media_accounts
  resources :phone_numbers
  resources :profiles

  # static pages are public pages
  root to: redirect('/home') # redirect root to /home
  get 'home'    => 'static_pages#home', as: :home_page
  get 'about'   => 'static_pages#about', as: :about_page

  # pages containing text only
  get 'about'    => 'text_pages#about', as: :help_page
  get 'tos'     => 'text_pages#tos', as: :terms_page
  get 'privacy' => 'text_pages#privacy', as: :privacy_page

  # everything in the dashboard
  get 'dashboard', to: redirect('/dashboard/overview'), status: 302
  get 'dashboard/overview' => 'dashboard#overview'
  get 'dashboard/profile'  => 'dashboard#profile'
  get 'dashboard/account'  => 'dashboard#account'
  get 'dashboard/billing'  => 'dashboard#billing'
  get 'dashboard/messages' => 'dashboard#messages'

  # user signups and registration
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # public pages
  get 'search' => 'public_pages#search'
  get ':username' => 'public_pages#profile'
end
