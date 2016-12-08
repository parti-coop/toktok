class AddProposerEmailAndProposerPhoneToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :proposer_email, :string
    add_column :projects, :proposer_phone, :string
  end
end
