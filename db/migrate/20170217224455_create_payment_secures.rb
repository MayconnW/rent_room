class CreatePaymentSecures < ActiveRecord::Migration
  def change
    create_table :payment_secures do |t|
      t.references :rent, index: true, foreign_key: true
      t.float :value

      t.timestamps null: false
    end
  end
end
