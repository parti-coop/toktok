class ChangeNotNullTitleOfProposals < ActiveRecord::Migration[5.0]
  def change
    change_column_null :proposals, :title, false
  end
end
