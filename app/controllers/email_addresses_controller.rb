class EmailAddressesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def destroy
    render json: EmailAddress.destroy(params[:id])
  end
end
