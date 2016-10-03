class PaymentsHandlerController < ApplicationController
  before_action :authenticate_user!

  def deposit
    params = deposit_params
    if params[:method] == 'test' && Rails.env.production?
      amount = params[:amount].to_d
      current_user.account.withdraw amount
    elsif params[:method] == 'test'
      raise 'Test is not available in production'
    else
      # TODO handle legit deposits
    end
  end

  def withdrawal
    params = withdrawal_params
    if params[:method] == 'test' && Rails.env.production?
      amount = params[:amount].to_d
      current_user.account.withdraw amount
    elsif params[:method] == 'test'
      raise 'Test is not available in production'
    else
      # TODO handle legit deposits
    end
  end

  private

    def deposit_params
      params.permit(:method, :amount)
    end

    def withdrawal_params
      params.permit(:method, :amount)
    end
end
