class AddMatchingStaffMessageToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :matching_staff_message, :text
  end
end
