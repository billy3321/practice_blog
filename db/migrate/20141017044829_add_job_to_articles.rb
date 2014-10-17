class AddJobToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :job, :string
  end
end
