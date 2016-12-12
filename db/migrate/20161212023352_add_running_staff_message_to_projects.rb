class AddRunningStaffMessageToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :running_staff_message, :text
  end
end
