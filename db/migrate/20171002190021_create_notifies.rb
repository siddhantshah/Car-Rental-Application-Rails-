class CreateNotifies < ActiveRecord::Migration[5.1]
  def change
    create_table :notifies do |t|
      t.string :email
      t.string :license

      t.timestamps
    end
  end
end
