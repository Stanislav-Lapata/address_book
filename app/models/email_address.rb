class EmailAddress < ActiveRecord::Base
  belongs_to :person
  validates :email, presence: { message: "Email address can't be blank"}
end
