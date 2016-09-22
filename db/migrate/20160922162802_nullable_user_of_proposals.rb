class NullableUserOfProposals < ActiveRecord::Migration[5.0]
  def change
    change_column_null :proposals, :user_id, true

    rename_column :proposals, :user_name, :proposer_name
    rename_column :proposals, :user_email, :proposer_email
    rename_column :proposals, :user_phone, :proposer_phone
  end
end
