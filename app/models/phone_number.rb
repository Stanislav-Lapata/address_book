class PhoneNumber < ActiveRecord::Base
    belongs_to :person
    validates :phone_number, presence: { message: "Phone number can't be blank"}
end
