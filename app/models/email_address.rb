class EmailAddress < ActiveRecord::Base
  belongs_to :person
  validates :email, presence: true
end
