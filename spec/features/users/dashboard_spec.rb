require 'rails_helper'
RSpec.describe 'can visit a users show page' do
  before :each do
     
    visit dashboard_path
  end
  describe 'can visit a users dashboard' do
    it 'can visit a users show page and see there attributes' do
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@user.full_name}!")
    end
  end
end