class CreateAssignedCommittees < ActiveRecord::Migration[5.0]
  def change
    create_table :assigned_committees do |t|
      t.references :committee, null: false, index: true
      t.references :project, null: false, index: true
      t.timestamps null: false
    end
    add_index :assigned_committees, [:committee_id, :project_id], unique: true
  end
end
