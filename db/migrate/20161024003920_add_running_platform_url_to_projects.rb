class AddRunningPlatformUrlToProjects < ActiveRecord::Migration[5.0]
  def change
  	add_column :projects, :running_platform_url, :string
  end
end
