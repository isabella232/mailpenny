# controller for the dashboard
class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

  def update
  end

  private

  def profile_params
    params.require(:user).permit(:avatar)
  end

end
