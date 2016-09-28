class AddProposerDescriptionAtProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :proposer_description, :text
  end
end
