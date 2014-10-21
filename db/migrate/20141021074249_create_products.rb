class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :product_group_id
      t.string :name

      t.timestamps
    end
  end
end
