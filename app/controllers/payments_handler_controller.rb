class PaymentsHandlerController < ApplicationController
  before_action :authenticate_user!

  def deposit
    params = deposit_params
    raise 'Test is not available in production' if params[:method] == 'test' && Rails.env.production?
    amount = params[:amount].to_d
    current_user.account.deposit amount
  end

  def withdrawal
    params = withdrawal_params
    raise 'Test is not available in production' if params[:method] == 'test' && Rails.env.production?
    amount = params[:amount].to_d
    current_user.account.withdraw amount
  end

  private

    def deposit_params
      params.permit(:method, :amount)
    end

    def withdrawal
      params.permit(:method, :amount)
    end
end
