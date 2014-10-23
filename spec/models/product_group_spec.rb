require 'spec_helper'

describe ProductGroup do
  let(:product_group) {FactoryGirl.create(:product_group)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :product_group
    }.to change { ProductGroup.count }.by(1)
  end

  it "destory_dependent_product" do
    3.times do
      FactoryGirl.create(:product, product_group: product_group)
    end
    expect {
      product_group.destroy
    }.to change { Product.count }.by(-3)
  end
end
