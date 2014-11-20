class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  max_paginates_per 10
  validates_presence_of :name, :content, :commentable_id, :commentable_type
end
