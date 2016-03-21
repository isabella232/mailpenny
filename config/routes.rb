Rails.application.routes.draw do

  ## devise controllers for humen
  devise_for :human, controllers: {
    confirmations: 'human/confirmations',
    passwords: 'human/passwords',
    registrations: 'human/registrations',
    sessions: 'human/sessions',
    unlocks: 'human/unlocks',
    # commenting the below because omniauth gem isn't installed
    # omniauth_callbacks: 'human/omniauth_callbacks'
  }, skip: [:sessions]
  ## custom routes for humen
  as :human do
    get 'login' => 'human/sessions#new', :as => :new_human_session
    post 'login' => 'human/sessions#create', :as => :human_session
    delete 'logout' => 'human/sessions#destroy', :as => :destroy_human_session
    get 'register' => 'human/registrations#new', as: :register
  end
  get 'send_verify_code' => 'paywall#send_verify_code'
  get 'verify'=>'paywall#verify'
  post 'verify'=>'paywall#verify'
  get 'charges/new'
  get 'charges/create'

  # static pages
  root :to => redirect('/login')
  #get 'about'   => 'static_pages#about'
  #get 'contact' => 'static_pages#contact'

  # email API
  #post 'emails/recieve'       => 'emails#recieve'
  #get 'emails/recieve'        => 'emails#recieve'
  #get 'emails/welcome'        => 'emails#welcome'
  #get 'emails/create_address' => 'emails#create_address'
  #post 'emails/payment_recieved' => 'emails#payment_recieved'

  post 'recieve' => 'paywall#recieve'
  # get 'register' => 'human#register'
  # post 'register' => 'paywall#register'
  post 'payment_recieved' => 'paywall#payment_recieved'
  #get 'paywall/home' => 'paywall#home'
  get 'settings' => 'paywall#settings', as: :settings
  get 'transactions' => 'paywall#transactions'
  get 'inbox' => 'paywall#inbox'
  get 'qr' => 'paywall#qr'
  get 'send_complex_message' => 'paywall#send_complex_message'
  post 'update_user' => 'paywall#update_user'
  post 'whitelist_delete' => 'paywall#whitelist_delete'
  get 'whitelist' => 'paywall#whitelist'
  post 'whitelist_add' => 'paywall#whitelist_add'
  post 'update_user' => 'paywall#update_user'
  post 'payment_transfer' => 'paywall#payment_transfer'
  get 'setpassword' => 'paywall#setpassword'
  post 'setpassword' => 'paywall#setpassword'
  post 'activate' => 'paywall#activate'

  # profile
  post 'change_pass' => 'paywall#change_pass'
  post 'change_prof' => 'paywall#change_prof'
  post 'add_email' => 'paywall#add_email'
  post 'delete_emails' => 'paywall#delete_emails'
  post 'add_phones' => 'paywall#add_phones'
  post 'delete_phones' => 'paywall#delete_phones'
  post 'send_email_profile' => 'paywall#send_email_profile'
  post 'send_sms_profile' => 'paywall#send_sms_profile'
  # billing
  get 'billing' => 'payments_handler#billing', as: :billing
  # add a card
  post 'add-card' => 'payment_handler#add_card'

  # charges
  resources :charges

  # messenger -- because the control sends messages, get it? Hahahahaha
  post '/messenger/mail' => 'messenger/mail', as: :mail_messenger
  post '/messenger/text' => 'messenger/text', as: :text_messenger

  ## The Humen routes by Devise
  # devise_for :humen, skip: [:sessions]
  # as :humen do
  #   # sessions
  #   get '/login(.:format)' => 'devise/sessions#new', as: :new_human_session
  #   post '/login(.:format)' => 'devise/sessions#create', as: :human_session
  #   delete 'logout' => 'devise/sessions#destroy', as: :destroy_human_session
  # end
  
  get ':username' => 'paywall#profile'
end
