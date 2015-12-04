class RenameReviewColumn < ActiveRecord::Migration
  def change
    rename_column :reviews, :type, :status
  end
end
