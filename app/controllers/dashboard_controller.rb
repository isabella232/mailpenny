# controller for the dashboard
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def overview
  end

  def profile
    @profile = current_user.profile
  end

  def account
  end

  def billing
  end

  def messages
  end
end
