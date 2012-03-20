class CreateFavoriteLists < ActiveRecord::Migration
  def change
    create_table :favorite_lists do |t|
      t.integer :menu_id
      t.string :ip_address

      t.timestamps
    end
  end
end
