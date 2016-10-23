class AddOnRunningToProjects < ActiveRecord::Migration[5.0]
  def change
  	add_column :projects, :on_running, :boolean, default: false
  end
end
