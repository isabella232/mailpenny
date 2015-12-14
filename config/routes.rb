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
end
