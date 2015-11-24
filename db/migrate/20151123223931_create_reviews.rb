class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :order, index: true, foreign_key: true
      t.text :text
      t.integer :type, default: 0
      t.boolean :hidden

      t.timestamps null: false
    end
  end
end
