require "spec_helper"

describe "Articles" do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) {FactoryGirl.create(:category)}
  let(:article) { FactoryGirl.create(:article, user: user, category: category)}
  let(:comment) {FactoryGirl.create(:comment, article: article)}
  let(:new_article) do
    {
      :title => "new_article_title",
      :content => "new_article_content",
      :user_id => user.id
    }
  end

  describe "before login" do
    describe "#index" do
      it "success" do
        get "/articles"
        expect(response).to be_success
      end
    end

    describe "#new" do
      it "success" do
        get "/articles/new"
        expect(response).to be_redirect
      end
    end

    describe "#show" do
      it "success" do
        get "/articles/#{article.id}"
        expect(response).to be_success
      end
    end

    describe "#edit" do
      it "success" do
        get "/articles/#{article.id}/edit"
        expect(response).to be_redirect
      end
    end
  end

  describe "after login" do
    before { sign_in(user) }
    after { sign_out }

    describe "#index" do
      it "success" do
        get "/articles"
        expect(response).to be_success
      end
    end

    describe "#new" do
      it "success" do
        get "/articles/new"
        expect(response).to be_success
      end
    end

    describe "#show" do
      it "success" do
        get "/articles/#{article.id}"
        expect(response).to be_success
      end
    end

    describe "#edit" do
      it "success" do
        get "/articles/#{article.id}/edit"
        expect(response).to be_success
      end
    end

    describe "#create" do
      it "success" do
        expect {
          post "/articles", :article => new_article
        }.to change { Article.count }.by(1)
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "success" do
        update_data = { :content => "new_content" }
        put "/articles/#{article.id}", :article => update_data
        expect(response).to be_redirect
        article.reload
        expect(article.content).to match(update_data[:content])
      end
    end

    describe "nested #update" do
      it "success" do
        comment
        update_comment_data = {
          :comments_attributes => [
            {
              :id => comment.id,
              :name => 'new_comment_name',
              :content => 'new_comment_content'
            }
          ]
        }
        put "/articles/#{comment.article.id}", :article => update_comment_data
        expect(response).to be_redirect
        comment.reload
        expect(comment.name).to match(update_comment_data[:comments_attributes][0][:name])
        expect(comment.content).to match(update_comment_data[:comments_attributes][0][:content])
      end
    end

    describe "nested #update delete" do
      it "success" do
        comment
        update_comment_data = {
          :comments_attributes => [
            {
              :id => comment.id,
              :_destroy => 1
            }
          ]
        }
        comment_count = Comment.count
        put "/articles/#{comment.article.id}", :article => update_comment_data
        expect(response).to be_redirect
        expect(comment_count - Comment.count).to eq(1)
      end
    end

    describe "#destroy" do
      it "success" do
        article
        expect {
          delete "/articles/#{article.id}"
        }.to change { Article.count }.by(-1)
        expect(response).to be_redirect
      end
    end

    it "should have sign out link" do
      get root_path
      expect(response.body).to match("Sign out")
    end
  end
end
