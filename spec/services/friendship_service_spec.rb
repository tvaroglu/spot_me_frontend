require 'rails_helper'

describe FriendshipService, :vcr, type: :service do
  describe 'class methods' do
    describe '.get_friends' do
      it "returns a hash with the user's friends" do
        expect(FriendshipService.get_friends(1).class).to eq(Hash)
      end
    end

    describe '.add_friend' do
      it 'returns a hash with the followed user' do
        params = {
          user_id: 1,
          followee_id: 10
        }
        expect(FriendshipService.add_friend(params).class).to eq(Hash)
      end
    end

    describe '.get_friends_at_gym' do
      it "returns a hash with the user's friends at the gym" do
        expect(FriendshipService.get_friends_at_gym('BJBXzKYxQAXZKb5W6HrRnA', 1)).to be_a(Hash)
      end
    end

    describe '.get_non_friends_at_gym' do
      it 'returns a hash of the users at the gym who the user is not following' do
        params = { yelp_gym_id: 'BJBXzKYxQAXZKb5W6HrRnA', user_id: 1 }
        expect(FriendshipService.get_non_friends_at_gym(params)).to be_a(Hash)
      end
    end
  end
end
