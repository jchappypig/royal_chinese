class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :category
      t.float :price
      t.string :dish_type
      t.boolean :is_vegetarian, :default => false

      t.timestamps
    end
  end
end
