class CreateMainslides < ActiveRecord::Migration[5.0]
  def change
    create_table :mainslides do |t|
      t.integer :order, null: false
      t.string :image, null: false
      t.text :url

      t.timestamps
    end
  end
end
