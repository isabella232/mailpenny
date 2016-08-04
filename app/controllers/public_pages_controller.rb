# pages that contain user information but aren't private
class PublicPagesController < ApplicationController
  def search
  end

  def profile
    profile_username = params[:username]
    @profile_user = User.find_by(username: profile_username)
  end
end
