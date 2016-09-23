class AddCommitteeToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :committee, index: true
  end
end
