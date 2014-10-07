require 'spec_helper'

describe "Static pages" do

  describe "Index" do
    it "should have content" do
      visit root_path
      expect(page).to have_content('Practice Blog')
    end
  end

  describe "Help" do
    it "should have content" do
      visit '/help'
      expect(page).to have_content('Help')
    end
  end

end
