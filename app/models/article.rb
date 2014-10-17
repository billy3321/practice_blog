class Article < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :user
  belongs_to :category
  max_paginates_per 10
  validates_presence_of :title, :content, :user_id

  default_scope { order(created_at: :desc) }

  def set_job(job)
    $redis.set(id, job)
  end

  def get_job()
    $redis.get(id)
  end
end
