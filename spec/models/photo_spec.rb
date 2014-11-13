require 'spec_helper'
require 'carrierwave/test/matchers'

describe Photo do
  let(:photo) { FactoryGirl.create(:photo) }

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :photo
    }.to change { Photo.count }.by(1)
  end

  describe ImageUploader do
    include CarrierWave::Test::Matchers
    let(:user) { FactoryGirl.create(:user) }

    before do
      ImageUploader.enable_processing = true
      @photo = Photo.create!
      @uploader = ImageUploader.new(@photo, :image)
      @uploader.store!(File.open(File.join(Rails.root, '/spec/fixtures/files/test.jpg')))
    end

    after do
      ImageUploader.enable_processing = false
      @uploader.remove!
    end

    context 'the thumb version' do
      it "should scale down a landscape image to be exactly 200 by 200 pixels" do
        @uploader.thumb.should have_dimensions(200, 200)
      end
    end

    it "should make the image readable only to the owner and not executable" do
      @uploader.should have_permissions(0600)
    end
  end
end
