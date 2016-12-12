class AddPrimaryCommitteeIdToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :primary_committee_id, :integer
  end
end
