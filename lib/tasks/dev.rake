namespace :dev do

  desc "Generate fake data"
  task :fake => [
    "dev:fake_users",
    "dev:fake_categories",
    "dev:fake_articles",
    "dev:fake_comments",
    "dev:fake_product_groups",
    "dev:fake_products"
    ]

  task :fake_users => :environment do
    User.destroy_all
    User.create!(:name => "Admin", :email => Settings.admin_email, :password => "12345678", :password_confirmation => "12345678")
  end

  task :fake_categories => :environment do
    Category.destroy_all
    Category.create!(:name => "Fake")
  end

  task :fake_articles => :environment do
    Article.destroy_all
    Article.create!(:title => "Fake Article", :content => "Generate by Dev Fake", :category_id => Category.first.id, :user_id => User.first.id)
  end

  task :fake_comments => :environment do
    Comment.destroy_all
    Comment.create!(:name => "Fake User", :content => "Fake Content 1", :article_id => Article.first.id)
    Comment.create!(:name => "Fake User", :content => "Fake Content 2", :article_id => Article.first.id)
  end

  task :fake_product_groups => :environment do
    ProductGroup.destroy_all
    ProductGroup.create!(:name => "Fake Product Group")
  end

  task :fake_products => :environment do
    Product.destroy_all
    Product.create!(:name => "Fake Product", :product_group_id => ProductGroup.first.id)
  end
end


