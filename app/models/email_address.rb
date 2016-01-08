class EmailAddress < ActiveRecord::Base
  belongs_to :person
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: { message: "Email address can't be blank"}
  validates :email, format: { with: VALID_EMAIL, message: "Email address invalid" }
end
