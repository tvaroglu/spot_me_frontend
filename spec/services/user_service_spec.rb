require 'rails_helper'

describe UserService, :vcr, type: :service do
  describe 'class methods' do
    it "returns a hash with the user's details" do      
      expect(UserService.get_user(1).class).to eq(Hash)
    end
  end
end
