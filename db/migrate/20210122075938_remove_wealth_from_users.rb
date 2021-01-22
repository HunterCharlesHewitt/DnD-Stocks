class RemoveWealthFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :wealth
    remove_column :users, :minute_stocks
    remove_column :users, :day_stocks
    remove_column :users, :company_invested
    remove_column :users, :reh
    add_column :users, :starting_wealth, :integer
  end
end
