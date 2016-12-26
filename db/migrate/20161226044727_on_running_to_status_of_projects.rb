class OnRunningToStatusOfProjects < ActiveRecord::Migration[5.0]
  def up
    ActiveRecord::Base.transaction do
      Project.where(on_running: true).each do |project|
        project.update_columns(on_running: false, status: 'running')
      end

      remove_column :projects, :on_running
    end
  end
end
