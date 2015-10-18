class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :last_seen_task
      t.string :ip
      t.boolean :vip, default: false
      t.boolean :banned, default: false

      t.timestamps null: false
    end
  end
end
