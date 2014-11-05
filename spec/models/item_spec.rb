require 'spec_helper'

describe Item do
  let(:item) {FactoryGirl.create(:item)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :item
    }.to change { Item.count }.by(1)
  end
end