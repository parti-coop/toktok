class CreateTimelines < ActiveRecord::Migration[5.0]
  def change
    create_table :timelines do |t|
		t.string :actor 
		t.string :image
		t.text :body, null: false
		t.references :project, index: true, null: false
		t.references :congressman, index: true
		t.datetime :timeline_date, null: false
		
		t.timestamps null: false
    end
  end
end
