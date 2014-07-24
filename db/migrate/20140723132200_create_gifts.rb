class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.integer :appeal_id, null: false
      t.integer :amount, null: false
      t.string :donor, null: false
      t.timestamps
    end
  end
end
