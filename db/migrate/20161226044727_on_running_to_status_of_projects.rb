class OnRunningToStatusOfProjects < ActiveRecord::Migration[5.0]
  def up
    ActiveRecord::Base.transaction do
      Project.where(on_running: true).each do |project|
        project.update_columns(status: 'running')
      end

      Project.where.not(on_running: true).each do |project|
        project.update_columns(status: '')
      end

      remove_column :projects, :on_running
    end
  end
end
