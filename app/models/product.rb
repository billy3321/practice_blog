class Product < ActiveRecord::Base
  belongs_to :product_group
  validates_presence_of :name, :product_group_id
  has_and_belongs_to_many :items
end
