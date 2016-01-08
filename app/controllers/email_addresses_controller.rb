class EmailAddressesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def destroy
    binding.pry
    render json: EmailAddress.destroy(params[:id])
  end
end
