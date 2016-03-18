Rails.application.routes.draw do
  devise_for :humen, skip: [:sessions]
  as :human do
    get 'login' => 'devise/sessions#new', :as => :new_human_session
    post 'login' => 'devise/sessions#create', :as => :human_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_human_session
    get 'register' => 'devise/registrations#new'
  end


  get 'charges/new'

  get 'charges/create'

  # static pages
  root 'paywall#login'
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
  get 'settings' => 'paywall#settings'
  get 'transactions' => 'paywall#transactions'
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
  get ':username' => 'paywall#profile'
  post 'change_pass' => 'paywall#change_pass'
  post 'change_prof' => 'paywall#change_prof'
  post 'add_email' => 'paywall#add_email'
  post 'delete_emails' => 'paywall#delete_emails'
  post 'add_phones' => 'paywall#add_phones'
  post 'delete_phones' => 'paywall#delete_phones'
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
end
