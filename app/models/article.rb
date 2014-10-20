class Article < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :user
  belongs_to :category
  max_paginates_per 10
  validates_presence_of :title, :content, :user_id

  default_scope { order(created_at: :desc) }

  before_save :delay_set_random_string

  def delay_set_random_string
    article.delay_for(5.minutes).set_random_string(article.content)
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
end
