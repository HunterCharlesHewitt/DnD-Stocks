class AddDescriptionToCompanys < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :description, :string
  end
end
