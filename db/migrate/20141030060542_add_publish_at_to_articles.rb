class AddPublishAtToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :publish_at, :date
  end
end
