class Article < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :category
  max_paginates_per 10
end
