class Product < ActiveRecord::Base
  belongs_to :product_group
  has_and_belongs_to_many :items
end
