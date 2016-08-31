class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :user, null: false
      t.string :title
      t.string :body
      t.timestamps null: false
    end
  end
end
