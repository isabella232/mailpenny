# controller for the dashboard
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def account
  end

  def billing
  end

  def inbox
    # conversations for this user latest first
    @conversations = current_user.conversations.sort_by { |c| c.messages.last.created_at }.reverse
  end
end
