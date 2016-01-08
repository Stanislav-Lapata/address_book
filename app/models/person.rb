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
  validates_uniqueness_of :first_name, scope: :last_name

  def self.to_csv
    attributes = %w{id first_name last_name email_addresses phone_numbers}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |person|
        csv << attributes.map do |attr|
         person.send(attr)
       end
      end
    end
  end
end
