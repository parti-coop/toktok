class CreateParticipations < ActiveRecord::Migration[5.0]
  def change
    create_table :participations do |t|
      t.references :user, null: false, index: true
      t.references :project, null: false, index: true
      t.timestamps null: false
    end

    add_index :participations, [:user_id, :project_id], unique: true

    add_column :projects, :participations_count, :integer, default: 0
  end
end
