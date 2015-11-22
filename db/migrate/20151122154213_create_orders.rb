class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :link
      t.references :good, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :external_id
      t.integer :external_done
      t.integer :external_need
      t.datetime :date_done
      t.boolean :done

      t.timestamps null: false
    end
  end
end
