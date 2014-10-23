class ProductGroup < ActiveRecord::Base
  has_many :products, :dependent => :destroy
end
