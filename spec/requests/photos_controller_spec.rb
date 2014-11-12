require 'spec_helper'

describe PhotosController do
  let(:user) { FactoryGirl.create(:user) }
  let(:photo) { FactoryGirl.create(:photo) }
  let(:new_photo) do
    {
      :title => "new_photo_title",
      :description => "new_photo_desc",
      :user_id => user.id
    }
  end
  before { sign_in(user) }
  after { sign_out }

  describe "#new" do
    it "success" do
      get "/photos/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/photos/#{photo.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/photos", :photo => new_photo
      }.to change { Photo.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      photo
      update_data = { :title => "new_title" }
      put "/photos/#{photo.id}", :photo => update_data
      expect(response).to be_redirect
      photo.reload
      expect(photo.title).to match(update_data[:title])
    end
  end

  describe "#destroy" do
    it "success" do
      photo
      expect {
        delete "/photos/#{photo.id}"
      }.to change { Photo.count }.by(-1)
      expect(response).to be_redirect
    end
  end
end