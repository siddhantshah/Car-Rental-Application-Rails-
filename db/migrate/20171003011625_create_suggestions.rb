class CreateSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :suggestions do |t|
      t.string :location
      t.string :model
      t.string :manufacturer
      t.string :style

      t.timestamps
    end
  end
end
