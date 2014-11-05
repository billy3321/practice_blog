require 'spec_helper'

describe Product do
  FactoryGirl.create_list(:item, 2)
  let(:product) { FactoryGirl.create(:product) }

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :product
    }.to change { Product.count }.by(1)
  end

  it "association with item" do
    product
    product.items = Item.all
    expect(product.items.length).to eq(Item.joins(:products).where("products.id = #{product.id}").count("items.id"))
  end
end
