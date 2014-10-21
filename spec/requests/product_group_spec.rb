require "spec_helper"

describe "ProductGroups" do

  let(:user) { FactoryGirl.create(:user) }
  let(:category) {FactoryGirl.create(:category)}
  let(:article) { FactoryGirl.create(:article, user: user, category: category)}
  let(:product_group) {FactoryGirl.create(:product_group, article: article)}
  let(:new_product_group) do
    {
      :name => "new_product_group_name",
      :name => "new_product_group_name",
      :article_id => article.id
    }
  end

  describe "#new" do
    it "success" do
      get "/product_groups/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/product_groups/#{product_group.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/product_groups", :product_group => new_product_group
      }.to change { ProductGroup.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      product_group
      update_data = { :name => "new_name" }
      put "/product_groups/#{product_group.id}", :product_group => update_data
      expect(response).to be_redirect
      product_group.reload
      expect(product_group.name).to match(update_data[:name])
    end
  end

  describe "#destroy" do
    it "success" do
      product_group
      expect {
        delete "/product_groups/#{product_group.id}"
      }.to change { ProductGroup.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end