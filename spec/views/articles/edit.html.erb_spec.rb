require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :user_id => 1,
      :title => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", article_path(@article), "post" do
      assert_select "input#article_user_id[name=?]", "article[user_id]"
      assert_select "input#article_title[name=?]", "article[title]"
      assert_select "textarea#article_content[name=?]", "article[content]"
    end
  end
end
