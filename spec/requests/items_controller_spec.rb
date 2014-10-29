require "spec_helper"

describe "Item" do


  let(:item) {FactoryGirl.create(:item)}
  let(:new_item) do
    {
      :name => "new_item_name",
    }
  end

  describe "#new" do
    it "success" do
      get "/items/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/items/#{item.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/items", :item => new_item
      }.to change { Item.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      item
      update_data = { :name => "new_name" }
      put "/items/#{item.id}", :item => update_data
      expect(response).to be_redirect
      item.reload
      expect(item.name).to match(update_data[:name])
    end
  end

  describe "#destroy" do
    it "success" do
      item
      expect {
        delete "/items/#{item.id}"
      }.to change { Item.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end