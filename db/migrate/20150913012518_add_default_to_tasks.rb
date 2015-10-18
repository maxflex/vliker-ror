class AddDefaultToTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :likes, :integer, default: 0
  end
end
