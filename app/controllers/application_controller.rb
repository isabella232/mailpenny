class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
  def set_user_if_in_session
    id = session[:user_id]
    @current_user = User.find_by(id: id)
  end
end
