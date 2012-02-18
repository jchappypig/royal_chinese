class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :is_valid,  :default => true

      t.timestamps
    end
  end
end
