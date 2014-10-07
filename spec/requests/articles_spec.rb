require 'spec_helper'

describe "Articles" do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) {FactoryGirl.create(:category)}
  let(:article) { FactoryGirl.create(:article, user: user, category: category)}
  let(:commet) {FactoryGirl.create(:commet, article: article)}

  describe "before login" do
    it "show article" do
      visit "/articles/#{article.id}"
      it { should have_content(article.content)}
      it { should have_content(commet.content)}
    end
    it "cannot post new article" do
      visit edit_article_path(user)
      it { should have_title('Sign in') }
    end
  end

  describe "after login" do
    before do
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    it "should have sign out link" do
      it { should have_content('Sign out') }
    end
  end
end
