require 'rails_helper'

describe GymService, :vcr, type: :service do
  describe 'class methods' do
    describe '.get_gyms_near_user' do
      it 'returns a hash of the gyms near a given zip code' do
        expect(GymService.get_gyms_near_user('80227').class).to eq(Hash)
      end
    end

    describe '.get_gym' do
      it "returns a hash of a given gym's details" do
        result = GymService.get_gym('BJBXzKYxQAXZKb5W6HrRnA')
        expect(result.class).to eq(Hash)
      end
    end

    describe '.get_gym_users' do
      it "returns a hash of the users that belong to a given gym" do
        expect(GymService.get_gym_users('BJBXzKYxQAXZKb5W6HrRnA')).to be_a(Hash)
      end
    end
  end
end
