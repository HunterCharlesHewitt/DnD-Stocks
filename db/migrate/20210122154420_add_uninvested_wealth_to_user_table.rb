class AddUninvestedWealthToUserTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uninvested_wealth, :string
  end
end
