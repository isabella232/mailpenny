Rails.application.routes.draw do
  # routes for the dashboard
  get '/dashboard/profile'  => 'profiles#edit'
  get '/dashboard/billing'  => 'dashboard#billing'
  get '/dashboard/messages' => 'dashboard#messages'
  get '/dashboard/overview' => 'dashboard#overview'
  ## get '/dashboard/account' is in the user devise routes below

  ## devise controllers for users
  devise_for :user, controllers: {
    confirmations: 'user/confirmations',
    passwords: 'user/passwords',
    registrations: 'user/registrations',
    sessions: 'user/sessions',
    unlocks: 'user/unlocks',
    # commenting the below because omniauth gem isn't installed
    # omniauth_callbacks: 'user/omniauth_callbacks'
  }, skip: [:sessions]
  ## custom routes for users
  as :user do
    get 'login' => 'user/sessions#new', :as => :new_user_session
    post 'login' => 'user/sessions#create', :as => :user_session
    delete 'logout' => 'user/sessions#destroy', :as => :destroy_user_session
    get 'register' => 'user/registrations#new', as: :register
    get '/dashboard/account'  => 'user/registrations#edit'
  end

  post 'emails/recieve' =>'emails/recieve'

  get 'send_verify_code' => 'paywall#send_verify_code'
  get 'verify'=>'paywall#verify'
  post 'verify'=>'paywall#verify'
  get 'charges/new'
  get 'charges/create'

  # static pages
  root :to => 'static_pages#home'
  get 'privacy-policy'   => 'static_pages#privacy', as: :privacy_policy
  # get 'about'   => 'static_pages#about'
  # get 'contact' => 'static_pages#contact'

  get 'tweet' =>'paywall#tweet'
  post 'reply_email' => 'paywall#reply_email'
  post 'recieve' => 'paywall#recieve'
  post 'payment_recieved' => 'paywall#payment_recieved'
  get 'transactions' => 'paywall#transactions'
  post 'payment_transfer' => 'paywall#payment_transfer'
  get 'setpassword' => 'paywall#setpassword'
  post 'setpassword' => 'paywall#setpassword'
  post 'activate' => 'paywall#activate'

  # profile
  get ':username' => 'paywall#profile'
  post 'change_pass' => 'paywall#change_pass'
  post 'change_prof' => 'paywall#change_prof'
  post 'add_email' => 'paywall#add_email'
  post 'delete_emails' => 'paywall#delete_emails'
  post 'add_phones' => 'paywall#add_phones'
  post 'delete_phones' => 'paywall#delete_phones'
  post 'send_email_profile' => 'paywall#send_email_profile'
  post 'send_sms_profile' => 'paywall#send_sms_profile'
  # add a card
  post 'add-card' => 'payment_handler#add_card'

  # charges
  resources :charges

  # profiles
  resources :profiles
end
