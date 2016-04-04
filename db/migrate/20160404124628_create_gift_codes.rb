class CreateGiftCodes < ActiveRecord::Migration
  def change
    create_table :gift_codes do |t|
      t.references :good, index: true, foreign_key: true
      t.string :code
      t.boolean :activated, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
