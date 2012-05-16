class AddDefaultValueToDishType < ActiveRecord::Migration
  def up
    change_column :menus, :dish_type, :string, default: Menu::DISH_TYPES.first
    Menu.all.each do | menu |
      menu.dish_type = Menu::DISH_TYPES.first if menu.dish_type.blank?
    end
  end

  def down
    change_column :menus, :dish_type, :string, default: nil
  end
end
