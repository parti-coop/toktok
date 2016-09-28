class AddFacebookAndTwitterUrlAtCongressmen < ActiveRecord::Migration[5.0]
  def change
    add_column :congressmen, :facebook_url, :string
    add_column :congressmen, :twitter_url, :string
  end
end
