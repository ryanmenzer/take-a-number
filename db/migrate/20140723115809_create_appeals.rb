class CreateAppeals < ActiveRecord::Migration
  def change
    create_table :appeals do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :description
      t.integer :grid_size, null: false
      t.timestamps
    end
  end
end
