class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
end
