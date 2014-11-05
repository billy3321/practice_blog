class Settings < Settingslogic
  source "#{Rails.root}/config/config.yml"
  namespace Rails.env

  def self.initialize_redis
    $redis = Redis.new(Settings.redis)
  end
end