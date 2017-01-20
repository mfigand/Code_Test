class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|

      t.string :sender
      t.string :beneficiary
      t.string :amount
      t.string :status
      t.string :transfer_type

      t.references :bank, index: true

      t.timestamps null: false
    end
  end
end
