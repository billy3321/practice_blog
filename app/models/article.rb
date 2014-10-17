class Article < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :user
  belongs_to :category
  max_paginates_per 10
  validates_presence_of :title, :content, :user_id

  default_scope { order(created_at: :desc) }

  before_save do |article|
    begin
      set_random_string(article.id)
    end
  end

  def set_random_string(id)
    index = 'index_' + id.to_s
    random_string = SecureRandom.hex
    $redis.set(index, random_string)
  end

  def get_random_string()
    index = 'index_' + id.to_s
    $redis.get(index)
  end

  def set_job(job)
    $redis.set(id, job)
  end

  def get_job()
    $redis.get(id)
  end

end
