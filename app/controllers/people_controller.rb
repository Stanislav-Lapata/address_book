class PeopleController < ApplicationController
  skip_before_filter :verify_authenticity_token

  wrap_parameters :person, include: [:first_name, :last_name, :email_addresses_attributes, :phone_numbers_attributes]

  def index
    render json: Person.all.as_json(include: [:email_addresses_attributes, :phone_numbers_attributes])

  end

  def show
    render json: Person.find(params[:id])
  end

  def create

    person = Person.new(params_person)
    if person.save
      render json: person, include: [:email_addresses_attributes, :phone_numbers_attributes]
    else
      render json: {errors: person.errors.full_messages.join(', ')}
    end
  end

  def update
    person = Person.find(params[:id])
    if person.update(params_person)
      render json: person, include: [:email_addresses_attributes, :phone_numbers_attributes]
    else
      render json: {errors: person.errors.full_messages.join(', ')}
    end
  end

  def destroy
    render json: Person.destroy(params[:id])
  end

  def csv_files
    respond_to do |format|
      format.csv { send_data Person.all.to_csv, filename: "People-#{Date.today}.csv" }
    end
  end

  private

  def params_person
    params.require(:person).permit(:first_name, :last_name, email_addresses_attributes: [:id, :person_id, :email, :created_at, :updated_at, :_destroy], phone_numbers_attributes: [:id, :person_id, :phone_number, :created_at, :updated_at, :_destroy])
  end
end
