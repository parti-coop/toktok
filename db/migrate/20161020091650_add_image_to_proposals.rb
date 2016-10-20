class AddImageToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :image, :string
  end
end
