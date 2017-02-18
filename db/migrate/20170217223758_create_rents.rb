class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.references :room, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.float :price_month
      t.integer :day_payment
      t.string :price_secure
      t.integer :status

      t.timestamps null: false
    end
  end
end
