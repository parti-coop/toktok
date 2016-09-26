class CreateMentions < ActiveRecord::Migration[5.0]
  def change
    create_table :mentions do |t|
      t.references :congressman, null: false, index: true
      t.references :comment, null: false, index: true
      t.timestamps null: false
    end

    add_index :mentions, [:congressman_id, :comment_id], unique: true
  end
end
