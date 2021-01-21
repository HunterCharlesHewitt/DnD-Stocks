class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :minute_stocks_robot, default: [].to_yaml
      t.text :day_stocks_robot, default: [].to_yaml
      t.text :minute_stocks_human, default: [].to_yaml
      t.text :day_stocks_human, default: [].to_yaml
      t.text :minute_stocks_elf, default: [].to_yaml
      t.text :day_stocks_elf, default: [].to_yaml

      t.timestamps
    end
  end
end
