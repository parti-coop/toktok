class AddUserNameUserEmailUserPhoneToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :user_name, :string, null: false
    add_column :proposals, :user_email, :string
    add_column :proposals, :user_phone, :string
  end
end
