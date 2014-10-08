class Comment < ActiveRecord::Base
  belongs_to :article
  max_paginates_per 10
end
