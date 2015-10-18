class AddDefaultToReports < ActiveRecord::Migration
  def change
    change_column :tasks, :reports, :integer, default: 0
  end
end
