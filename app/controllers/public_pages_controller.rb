# pages that contain user information but aren't private
class PublicPagesController < ApplicationController
  def home
    @random_users = User.order('RANDOM()').limit(10)
  end

  def search
  end

  def profile
    @profile_user = User.find_by params_username
    not_found if @profile_user.nil? || @profile_user.profile.nil?
    @profile = @profile_user.profile

    @others = User.order('RANDOM()').first(4)

    @conversation = Conversation.new if user_signed_in?
  end

  private

    def params_username
      params.permit(:username)
    end
end
