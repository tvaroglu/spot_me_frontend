require 'rails_helper'

describe FriendshipService, :vcr, type: :service do
  describe 'class methods' do
    describe '.get_friends' do
      it "returns a hash with the user's friends" do
        actual = FriendshipService.get_friends(1)
        expect(actual).to be_a(Hash)

        expect(actual).to have_key(:data)
        expect(actual[:data]).to be_an(Array)
        expect(actual[:data]).to all(have_key(:id))
        expect(actual[:data]).to all(have_key(:type))
        expect(actual[:data]).to all(have_key(:attributes))

        expect(actual[:data].first[:id]).to be_a(String)
        expect(actual[:data].first[:type]).to eq('user')
        expect(actual[:data].first[:attributes]).to be_a(Hash)

        expect(actual[:data].first[:attributes]).to have_key(:email)
        expect(actual[:data].first[:attributes]).to have_key(:google_id)
        expect(actual[:data].first[:attributes]).to have_key(:google_image_url)
        expect(actual[:data].first[:attributes]).to have_key(:zip_code)
        expect(actual[:data].first[:attributes]).to have_key(:summary)
        expect(actual[:data].first[:attributes]).to have_key(:goal)
        expect(actual[:data].first[:attributes]).to have_key(:availability_morning)
        expect(actual[:data].first[:attributes]).to have_key(:availability_afternoon)
        expect(actual[:data].first[:attributes]).to have_key(:availability_evening)
        expect(actual[:data].first[:attributes]).to have_key(:full_name)
      end
    end

    describe '.add_friend and .delete_friend' do
      it 'adds and deletes a friend' do
        params = {
          user_id: 1,
          followee_id: 10
        }

        expect(FriendshipService.add_friend(params).class).to eq(Hash)

        params = {
          user_id: 1,
          id: 10
        }

        actual = FriendshipService.delete_friend(params)
        expect(actual.env.url.to_s).to eq('https://spotme-app-api.herokuapp.com/api/v1/users/1/friendships/10')
        expect(actual.status).to eq(204)
      end
    end

    describe '.get_friends_at_gym' do
      it "returns a hash with the user's friends at the gym" do
        actual = FriendshipService.get_friends_at_gym('BJBXzKYxQAXZKb5W6HrRnA', 1)
        expect(actual).to be_a(Hash)
      end
    end

    describe '.get_non_friends_at_gym' do
      it 'returns a hash of the users at the gym who the user is not following' do
        params = { yelp_gym_id: 'BJBXzKYxQAXZKb5W6HrRnA', user_id: 1 }
        actual = FriendshipService.get_non_friends_at_gym(params)
        expect(actual).to be_a(Hash)
      end
    end
  end
end
