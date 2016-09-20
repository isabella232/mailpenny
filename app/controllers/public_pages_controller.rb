# pages that contain user information but aren't private
class PublicPagesController < ApplicationController
  def home
  end

  def search
  end

  def profile
    profile_username = params[:username]
    @profile_user = User.find_by(username: profile_username)
    not_found if @profile_user.nil?
    @profile = @profile_user.profile
    not_found if @profile.nil?

    @conversation = Conversation.new if user_signed_in?
    render 'own_profile' if user_signed_in? && current_user == @profile_user
  end

  private
end
