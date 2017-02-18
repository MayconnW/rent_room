class CreatePaymentRents < ActiveRecord::Migration
  def change
    create_table :payment_rents do |t|
      t.references :rent, index: true, foreign_key: true
      t.integer :month
      t.float :value

      t.timestamps null: false
    end
  end
end
