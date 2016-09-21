class MigratePolymorphicAttachments < ActiveRecord::Migration[5.0]
  def up
    drop_table :proposal_attachments

    create_table :attachments do |t|
      t.string :source, null: false
      t.string :name, null: false
      t.string :source_type, null: false
      t.references :attachable, polymorphic: true, null: false, index: true
      t.timestamps null: false
    end
  end

  def down
    raise "unsupport!"
  end
end
