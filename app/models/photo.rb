class Photo < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments, as: :commentable, :dependent => :destroy
end
