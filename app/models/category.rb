class Category < ActiveRecord::Base
  has_many :articles
  max_paginates_per 10
  validates_presence_of :name
end
