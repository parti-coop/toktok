class AddDescriptionToMainslides < ActiveRecord::Migration[5.0]
  def change
    add_column :mainslides, :description, :text
  end
end
