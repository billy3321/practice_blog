require 'spec_helper'

describe Product do
  2.times do
    FactoryGirl.create :item
  end
  let(:product) { FactoryGirl.create(:product) }

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :product
    }.to change { Product.count }.by(1)
  end

  it "association with item" do
    product
    product.items = Item.all
    expect(product.items.length).to eq(Item.all.length)
  end
end
