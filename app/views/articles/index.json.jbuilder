json.array!(@articles) do |article|
  json.extract! article, :id, :user_id, :title, :content
  json.url article_url(article, format: :json)
end
