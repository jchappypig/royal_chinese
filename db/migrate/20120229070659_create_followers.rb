class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :name
      t.string :email
      t.boolean :is_subscribe, default: true

      t.timestamps
    end
  end
end
