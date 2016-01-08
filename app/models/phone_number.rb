class PhoneNumber < ActiveRecord::Base
    belongs_to :person
    validates :phone_number, presence: true
end
