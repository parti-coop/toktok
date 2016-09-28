class AddSummaryAtProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :summary, :text
  end
end
