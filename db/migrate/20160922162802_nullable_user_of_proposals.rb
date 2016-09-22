class NullableUserOfProposals < ActiveRecord::Migration[5.0]
  def change
    change_column_null :proposals, :user_id, null: true

    rename_column :proposals, :user_name, :proposer_name
    rename_column :proposals, :user_email, :proposer_email
    rename_column :proposals, :user_phone, :proposer_phone

    change_column_null :proposals, :proposer_email, null: false
    change_column_null :proposals, :proposer_phone, null: false
  end
end
