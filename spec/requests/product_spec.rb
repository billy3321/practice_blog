require "spec_helper"

describe "Products" do

  let(:product_group) {FactoryGirl.create(:product_group)}
  let(:product) {FactoryGirl.create(:product, product_group: product_group)}

  describe "#new" do
    it "success" do
      get "/product_group/#{product_group.id}/products/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/product_group/#{product_group.id}/products/#{product.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/product_group/#{product_group.id}/products", :product => new_product
      }.to change { Product.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      product
      update_data = { :name => "new_name" }
      put "/product_group/#{product_group.id}/products/#{product.id}", :product => update_data
      expect(response).to be_redirect
      product.reload
      expect(product.name).to match(update_data[:name])
    end
  end

  describe "#destroy" do
    it "success" do
      product
      expect {
        delete "/product_group/#{product_group.id}/products/#{product.id}"
      }.to change { Product.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end