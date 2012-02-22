class AddNameAndDescriptionToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :name, :string

    add_column :addresses, :description, :string

  end
end
