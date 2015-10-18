class AddDefaultToUsers < ActiveRecord::Migration
  def change
    change_column :users, :last_seen_task, :integer, default: 0
  end
end
