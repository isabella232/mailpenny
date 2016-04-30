class PhoneNumberController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @phone_number = current_user.phone_number || PhoneNumber.new
    render layout: 'dashboard'
  end

  def create
    @phone_number.new(profile_creation_params)
    respond_to do |format|
      if @phone_number.save
        format.html { redirect_to phone_number_path, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def profile_creation_params
    params.require(:profile).permit(:phone_number, :country_code, :verification_method)
  end

  def profile_verification_params
    params.require(:profile).permit(:verification_method, :verification_code)
  end
end
