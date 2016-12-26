class AddFailStaffMessageToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :fail_staff_message, :text
  end
end
