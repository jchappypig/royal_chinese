class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :menu_id
      t.string :ip_address

      t.timestamps
    end
  end
end
