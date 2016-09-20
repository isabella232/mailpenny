# pages that contain user information but aren't private
class PublicPagesController < ApplicationController
  def home
  end

  def search
  end

  def profile
    @profile_user = User.find_by params_username
    not_found if @profile_user.nil? || @profile_user.profile.nil?
    @profile = @profile_user.profile

    @conversation = Conversation.new if user_signed_in?
    render 'own_profile' if user_signed_in? && current_user == @profile_user
  end

  private

    def params_username
      params.permit[:username]
    end
end
