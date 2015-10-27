class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.integer :price
      t.string :bonus
      t.integer :page
      t.integer :count
      t.references :good_type, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
