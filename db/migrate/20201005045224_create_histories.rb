class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :money
      t.string :purpose
      t.timestamps null: false
    end
  end
end
