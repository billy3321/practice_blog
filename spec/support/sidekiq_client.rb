module SidekiqClient
  # 取得 queue 的 key
  def sidekiq_queues
    Sidekiq::Stats.new.queues.keys
  end

  #清除 queue
  def sidekiq_reset!
    sidekiq_queues.each{ |queue| Sidekiq::Queue.new(queue).clear }
    Sidekiq::ScheduledSet.new.map(&:delete) #清除Scheduled內的process
  end

  #讀取 queue 的數量
  def sidekiq_queue_size(queue_name = "default")
    Sidekiq::Queue.new(queue_name).size
  end

  #讀取 queue 裡的 jobs
  def sidekiq_queue_jobs(queue_name = "default")
    Sidekiq::Queue.new(queue_name).to_a.map{ |j| YAML::load(j.args.first) }
  end

  #取得 jobs 的數量
  def sidekiq_job_size(object, method, queue_name = "default")
    sidekiq_queue_jobs(queue_name).select{ |j| j[0] == object && j[1].to_s == method.to_s }.size
  end

  #取得有排程的 jobs
  def sidekiq_scheduled_jobs
    Sidekiq::ScheduledSet.new.to_a.map{ |j| YAML::load(j.args.first) }
  end

  #取得有排程的特定 jobs 的數量
  def sidekiq_scheduled_job_size(object, method)
    sidekiq_scheduled_jobs.select{ |j| j[0] == object && j[1].to_s == method.to_s }.size
  end

  #取得有排程的所有 jobs 的數量
  def sidekiq_scheduled_all_job_size
    Sidekiq::ScheduledSet.new.size
  end
end