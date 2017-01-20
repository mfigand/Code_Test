class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|

      t.string :iban
      t.integer :amount, default:0
      t.string :holder

      t.references :bank, index: true

      t.timestamps null: false
    end
  end
end
