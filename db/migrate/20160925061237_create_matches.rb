class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.references :project, null: false, index: true
      t.references :congressman, null: false, index: true
      t.string :status, null: false, default: 'calling'
      t.timestamps null: false
    end

    add_index :matches, [:project_id, :congressman_id], unique: true
  end
end
