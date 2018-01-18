class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :stock
      t.string :brand
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
