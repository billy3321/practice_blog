module SidekiqClient

  def sidekiq_queues
    Sidekiq::Stats.new.queues.keys
  end

  def sidekiq_reset!
    sidekiq_queues.each{ |queue| Sidekiq::Queue.new(queue).clear }
  end

  def sidekiq_queue_size(queue_name = "test")
    Sidekiq::Queue.new(queue_name).size
  end

  def sidekiq_queue_jobs(queue_name = "test")
    Sidekiq::Queue.new(queue_name).to_a.map{ |j| YAML::load(j.args.first) }
  end

  def sidekiq_job_size(object, method, queue_name = "test")
    sidekiq_queue_jobs(queue_name).select{ |j| j[0] == object && j[1].to_s == method.to_s }.size
  end

  def sidekiq_scheduled_jobs
    Sidekiq::ScheduledSet.new.to_a.map{ |j| YAML::load(j.args.first) }
  end

  def sidekiq_scheduled_job_match(object, method)
    sidekiq_scheduled_jobs.select{ |j| j[0] == object && j[1].to_s == method.to_s }.size
  end

  def sidekiq_scheduled_job_size
    sidekiq_scheduled_jobs.size
  end

  def sidekiq_scheduled_job_reset!
    Sidekiq::ScheduledSet.new.clear
  end

end