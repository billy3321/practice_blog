require 'spec_helper'

describe Product do
  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :product
    }.to change { Product.count }.by(1)
  end
end
