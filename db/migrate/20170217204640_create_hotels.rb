class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :description
      t.string :address
      t.string :cep

      t.timestamps null: false
    end
  end
end
