class AddColumnToProducts < ActiveRecord::Migration[5.1]
  def change
  	add_column :products, :present, :boolean, default: :false
  end
end
