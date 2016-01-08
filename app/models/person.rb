class Person < ActiveRecord::Base
  has_many :email_addresses, dependent: :destroy
  has_many :email_addresses_attributes, class_name: EmailAddress, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :phone_numbers_attributes, class_name: PhoneNumber, dependent: :destroy
  accepts_nested_attributes_for :email_addresses, :phone_numbers, allow_destroy: true

  validates :email_addresses, presence: true
  validates :phone_numbers, presence: true
  validates_uniqueness_of :first_name, scope: :last_name
  validate :presence_email_and_number



def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |product|
      csv << product.attributes.values_at(*column_names)
    end
  end
end

def self.to_csv
  attributes = %w{id first_name last_name email_addresses phone_numbers}

  CSV.generate(headers: true) do |csv|
    csv << attributes

    all.each do |person|
      csv << attributes.map do |attr|
       person.send(attr[3])
     end
    end
  end
end

def presence_email_and_number
  binding.pry
  if email_addresses_attributes.blank? && self.phone_numbers_attributes.blank?
    errors.add(:base, "blabla")
  end
end

=begin
def as_json(options={})
    super.merge(email_addresses_attributes: email_addresses.as_json)
  end
=end

end
