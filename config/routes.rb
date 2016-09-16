Rails.application.routes.draw do
  resources :social_media_accounts
  resources :phone_numbers
  resources :profiles

  # the root path
  root 'public_pages#home'

  # pages containing text only
  get 'about'   => 'text_pages#about', as: :about_page
  get 'tos'     => 'text_pages#tos', as: :terms_page
  get 'privacy' => 'text_pages#privacy', as: :privacy_page

  # everything in the dashboard
  get 'dashboard', to: redirect('/dashboard/overview'), status: 302
  get 'dashboard/account'  => 'dashboard#account'
  get 'dashboard/billing'  => 'dashboard#billing'
  get 'dashboard/inbox' => 'dashboard#inbox'

  # user signups and registration
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # public pages
  get 'search' => 'public_pages#search'
  get ':username' => 'public_pages#profile' # KEEP THIS ROUTE LAST
end
