Rails.application.routes.draw do
  devise_for :users

  as :user do
    get 'login' => 'users/sessions#new', as: :login_page
    post 'login' => 'users/sessions#create'
    delete 'logout' => 'users/sessions#destroy'
    get 'register' => 'users/registrations#new', as: :register_page
  end
end
