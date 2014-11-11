class CreateItemsProducts < ActiveRecord::Migration
  def change
    create_table :items_products, id: false do |t|
      t.belongs_to :item
      t.belongs_to :product
    end
  end
end
