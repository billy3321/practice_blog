class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :user
      t.string :title
      t.string :image
      t.text :description
    end
  end
end
