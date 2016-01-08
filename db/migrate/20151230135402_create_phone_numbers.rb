class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :phone_number
      t.integer :person_id
      t.timestamps null: false
    end
  end
end
