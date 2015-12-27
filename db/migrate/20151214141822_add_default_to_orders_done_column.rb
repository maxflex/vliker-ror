class AddDefaultToOrdersDoneColumn < ActiveRecord::Migration
  def change
    change_column :orders, :done, :boolean, :default => false
  end
end
