class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|

      t.string :name,unique: true
      t.string :address
      t.string :phone
      t.string :city
      t.string :state
      t.string :country
      t.integer :num_of_transfers, default:0


      t.timestamps null: false

    end
  end
end
