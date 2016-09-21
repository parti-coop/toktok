class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :body
      t.references :proposal, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
