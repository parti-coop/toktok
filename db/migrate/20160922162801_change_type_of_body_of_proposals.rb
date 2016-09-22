class ChangeTypeOfBodyOfProposals < ActiveRecord::Migration[5.0]
  def change
    change_column :proposals, :body, :text
  end
end
