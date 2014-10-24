class ProductGroup < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :products, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :name
end
