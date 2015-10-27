class CreateGoodTypes < ActiveRecord::Migration
  def change
    create_table :good_types do |t|
      t.string :title
      t.decimal :price
      t.string :icon
      t.integer :type_id
      t.timestamps null: false
    end
  end
end
