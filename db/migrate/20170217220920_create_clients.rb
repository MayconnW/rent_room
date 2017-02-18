class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.date :born
      t.string :country
      t.string :phone

      t.timestamps null: false
    end
  end
end
