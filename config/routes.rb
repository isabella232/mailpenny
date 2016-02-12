Rails.application.routes.draw do
  # static pages
  root 'static_pages#home'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  # email API
  post 'emails/recieve'       => 'emails#recieve'
  get 'emails/recieve'        => 'emails#recieve'
  get 'emails/welcome'        => 'emails#welcome'
  get 'emails/create_address' => 'emails#create_address'
  post 'emails/payment_recieved' => 'emails#payment_recieved'
  post 'paywall/recieve' => 'paywall#recieve'
  get 'paywall/register' => 'paywall#register'
  post 'paywall/register' => 'paywall#register'
  post 'paywall/payment_recieved' => 'paywall#payment_recieved'
  get 'paywall/login' => 'paywall#login'
  get 'paywall/home' => 'paywall#home'
  get 'paywall/qr' => 'paywall#qr'
  get 'paywall/send_complex_message' => 'paywall#send_complex_message'
end
