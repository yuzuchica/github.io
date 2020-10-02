class CreateHistorys < ActiveRecord::Migration[5.2]
  def change
    create_table :historys do |t|
      t.integer :user_id
      t.integer :money
      t.timestamps null: false
    end
  end
end
