class AddProposerToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :proposer, :string
  end
end
