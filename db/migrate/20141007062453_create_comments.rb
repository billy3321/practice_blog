class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.integer :article_id
      t.text :content

      t.timestamps
    end
  end
end
