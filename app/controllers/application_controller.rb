# The parent controller for all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include MailpennyHelper

  # render 404 pages
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  # redirect users after login
  def after_sign_in_path_for(_resource)
    dashboard_messages_path
  end

  # redirect users after logout
  def after_sign_out_path_for(_resource)
    root_path
  end
end
