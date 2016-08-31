class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :provider, null: false
      t.string :uid, null: false
      t.string :nickname, null: true
      t.string :image, null: true
      t.timestamps null: false
    end

    add_index :users, [:provider, :uid], unique: true
  end
end
