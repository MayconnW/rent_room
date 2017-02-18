class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :description
      t.string :number
      t.references :hotel, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
