class CreateCongressmen < ActiveRecord::Migration[5.0]
  def change
    create_table :congressmen do |t|
      t.string :name
      t.string :description
      t.string :party
      t.references :committee, foreign_key: true

      t.timestamps
    end
  end
end
