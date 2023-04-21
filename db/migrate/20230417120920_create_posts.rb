class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :price
      t.string :category
      t.string :product
      t.date :date
      t.boolean :purchase_status
      t.text :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
