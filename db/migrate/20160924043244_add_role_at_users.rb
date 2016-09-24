class AddRoleAtUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, default: 'citizen'
    add_index :users, :role
  end
end
