require "spec_helper"

describe "Comments" do

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:article) { FactoryGirl.create(:article, user: user, category: category) }
  let(:comment) { FactoryGirl.create(:comment, article: article) }
  let(:new_comment) do
    {
      :name => "new_comment_name",
      :content => "new_comment_content",
      :article_id => article.id
    }
  end

  describe "#new" do
    it "success" do
      get "/comments/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/comments/#{comment.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/comments", :comment => new_comment
      }.to change { Comment.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      comment
      update_data = { :content => "new_content" }
      put "/comments/#{comment.id}", :comment => update_data
      expect(response).to be_redirect
      comment.reload
      expect(comment.content).to match(update_data[:content])
    end
  end

  describe "#destroy" do
    it "success" do
      comment
      expect {
        delete "/comments/#{comment.id}"
      }.to change { Comment.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end
