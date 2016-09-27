class AddImageAtCongressmen < ActiveRecord::Migration[5.0]
  def change
    add_column :congressmen, :image, :string
  end
end
