class AddDefaultToReviews < ActiveRecord::Migration
  def change
    change_column :reviews, :hidden, :boolean, :default => false
  end
end
