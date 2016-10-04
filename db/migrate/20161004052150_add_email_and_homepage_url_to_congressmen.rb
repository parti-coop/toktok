class AddEmailAndHomepageUrlToCongressmen < ActiveRecord::Migration[5.0]
  def change
    add_column :congressmen, :email, :string
    add_column :congressmen, :homepage_url, :string
  end
end
