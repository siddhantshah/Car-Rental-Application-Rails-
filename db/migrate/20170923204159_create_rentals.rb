class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.string :email
      t.string :license
      t.timestamp :checkout
      t.timestamp :return
      t.integer :hours
      t.float :rental_charge
      t.string :status

      t.timestamps
    end
  end
end
