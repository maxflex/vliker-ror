class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true, foreign_key: true
      t.string :url
      t.string :url_original
      t.string :url_short
      t.integer :likes
      t.integer :need
      t.integer :priority, default: 0
      t.integer :reports
      t.integer :queue
      t.string :ip
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
