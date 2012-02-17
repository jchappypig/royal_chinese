class AddImageToMenu < ActiveRecord::Migration
  def self.up
    change_table :menus do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :menus, :image
  end
end
