class CreateTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :times do |t|
      t.integer :user_id
      t.integer :work
      t.timestamps null: false
    end
  end
end
