class CreateShares < ActiveRecord::Migration[6.1]
  def change
    create_table :shares do |t|
      t.integer :company_id
      t.integer :user_id
      t.integer :buy_price
      t.integer :rob_hum_elf

      t.timestamps
    end
  end
end
