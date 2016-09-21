class CreateProposalAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :proposal_attachments do |t|
      t.string :source, null: false
      t.string :name, null: false
      t.string :source_type, null: false
      t.references :proposal, null: false, index: true
      t.timestamps null: false
    end
  end
end
