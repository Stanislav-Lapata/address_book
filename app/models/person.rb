class Person < ActiveRecord::Base
  require 'csv'

  has_many :email_addresses, dependent: :destroy
  has_many :email_addresses_attributes, class_name: EmailAddress, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :phone_numbers_attributes, class_name: PhoneNumber, dependent: :destroy
  accepts_nested_attributes_for :email_addresses, :phone_numbers, allow_destroy: true

  validates :first_name, presence: { message: "First name can't be blank"}
  validates :last_name, presence: { message: "Last name can't be blank"}
  validates :email_addresses, presence: true
  validates :phone_numbers, presence: true
  validates_uniqueness_of :first_name, scope: :last_name, message: "Full name is not unique"

  def self.to_csv(options = {})
    column_names_to_header  = column_names.dup
    column_names_to_header << "email_addresses_attributes"
    column_names_to_header << "phone_numbers_attributes"
    CSV.generate(options) do |csv|
      csv << column_names_to_header
      all.each do |person|
        attributes = person.attributes.values_at(*column_names)
        attributes << person.email_addresses.map { |email| email.email }.join(",")
        attributes << person.phone_numbers.map { |number| number.phone_number }.join(",")
        csv << attributes
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      attributes = row.to_hash
      email = attributes["email_addresses_attributes"].split(',').map do |email|
        {"email"=> "#{email}"}
      end
      numbers = attributes["phone_numbers_attributes"].split(',').map do |number|
        {"phone_number"=>"#{number}"}
      end
      attributes["email_addresses_attributes"] = email
      attributes["phone_numbers_attributes"] = numbers
      binding.pry

      person= Person.new attributes
      unless person.save
        person = Person.find_by(first_name: attributes["first_name"], last_name: attributes["last_name"])
        Person.destroy(person.id)
        Person.create attributes
      end
    end
  end
end


