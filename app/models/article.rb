class Article < ActiveRecord::Base
  include Sidekiq::Worker
  has_many :comments, as: :commentable, :dependent => :destroy
  belongs_to :user
  belongs_to :category
  max_paginates_per 10
  validates_presence_of :title, :content, :user_id
  accepts_nested_attributes_for :comments, :reject_if => :all_blank, :allow_destroy => true

  default_scope { order(created_at: :desc) }

  after_save :delay_set_random_string
  scope :search_content, lambda { |query| where("content like ?", "%#{query}%") }
  scope :in_week, lambda { where("created_at >= ?", Time.now - 1.week) }

  def self.recent(t=(Time.now - 7.days))
    where(["created_at > ? ", t ])
  end

  def delay_set_random_string
    self.delay_for(5.minutes).set_random_string(self.content)
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
