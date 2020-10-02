class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer :work
      t.timestamps null: false
    end
  end
end
