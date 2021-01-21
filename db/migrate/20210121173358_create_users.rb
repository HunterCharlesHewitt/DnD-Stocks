class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.text :wealth, default: [].to_yaml
      t.text :minute_stocks, default: [].to_yaml
      t.text :day_stocks, default: [].to_yaml
      t.string :company_invested
      t.string :reh

      t.timestamps
    end
  end
end
