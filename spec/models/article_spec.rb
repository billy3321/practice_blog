require 'spec_helper'

describe "Article" do
  let(:user) { FactoryGirl.create(:user) }
  let(:article) { FactoryGirl.create(:article) }

  it "create and sidekiq work" do
    sidekiq_reset!
    expect(sidekiq_scheduled_all_job_size).to eq(0)
    new_article = Article.new(title: "new_article_title", content: "new_article_content", user_id: user.id)
    new_article.save
    expect(sidekiq_scheduled_job_size(new_article, :set_random_string)).to eq(1)
    expect(sidekiq_scheduled_all_job_size).to eq(1)
  end

  it "update and sidekiq work" do
    sidekiq_reset!
    expect(sidekiq_scheduled_all_job_size).to eq(0)
    article
    article.update(content: "new_content")
    expect(sidekiq_scheduled_job_size(article, :set_random_string)).to eq(2)
    expect(sidekiq_scheduled_all_job_size).to eq(2)
  end

  it "search_content scope work" do
    expect(Article.search_content('Article').size).to eq(Article.all.select { |i| i.content[/Article/i] }.size)
  end

  it "recent_content scope work" do
    FactoryGirl.create(:article, :created_at => (Time.now - 5.days))
    FactoryGirl.create(:article, :created_at => (Time.now - 2.days))
    FactoryGirl.create(:article, :created_at => (Time.now - 1.days))
    expect(Article.recent(Time.now - 3.days).size).to eq(Article.all.select { |i| i.created_at > (Time.now - 3.days) }.size)
  end
end
