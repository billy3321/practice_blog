require "spec_helper"



describe "Categories" do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:new_category) do
    {
      :name => "new_category"
    }
  end

  describe "before login" do

    describe "#index" do
      it "success" do
        get "/categories"
        expect(response).to be_redirect
      end
    end
  end

  describe "after login" do
    before { sign_in(user) }
    after { sign_out }

    describe "#index" do
      it "success" do
        get "/categories"
        expect(response).to be_success
      end
    end

    describe "#new" do
      it "success" do
        get "/categories/new"
        expect(response).to be_success
      end
    end

    describe "#show" do
      it "success" do
        get "/categories/#{category.id}"
        expect(response).to be_success
      end
    end

    describe "#edit" do
      it "success" do
        get "/categories/#{category.id}/edit"
        expect(response).to be_success
      end
    end

    describe "#create" do
      it "success" do
        expect {
          post "/categories", :category => new_category
        }.to change { Category.count }.by(1)
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "success" do
        category
        update_data = { :name => "new_name" }
        put "/categories/#{category.id}", :category => update_data
        expect(response).to be_redirect
        category.reload
        expect(category.name).to match(update_data[:name])
      end
    end

    describe "#destroy" do
      it "success" do
        category
        expect {
          delete "/categories/#{category.id}"
        }.to change { Category.count }.by(-1)
        expect(response).to be_redirect
      end
    end
  end
end
