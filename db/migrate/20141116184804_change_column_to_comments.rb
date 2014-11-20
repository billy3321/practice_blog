class ChangeColumnToComments < ActiveRecord::Migration
  def change
    rename_column :comments, :article_id, :commentable_id
    add_column :comments, :commentable_type, :string
  end
end
