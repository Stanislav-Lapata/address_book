class PhoneNumbersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def destroy
    render json: PhoneNumber.destroy(params[:id])
  end
end
