require 'rails_helper'

describe FriendshipService, :vcr, type: :service do
  describe 'class methods' do
    describe '.get_friends' do
      it "returns a hash with the user's friends if present" do
        actual = FriendshipService.get_friends(1)
        expect(actual).to be_a(Hash)
        expect(actual).to have_key(:data)

        data = actual[:data]
        expect(data).to be_an(Array)

        if data.size > 0
          expect(data).to all(have_key(:id))
          expect(data).to all(have_key(:type))
          expect(data).to all(have_key(:attributes))

          expect(data.first[:id]).to be_a(String)
          expect(data.first[:type]).to eq('user')
          expect(data.first[:attributes]).to be_a(Hash)

          expect(data.first[:attributes]).to have_key(:email)
          expect(data.first[:attributes]).to have_key(:google_id)
          expect(data.first[:attributes]).to have_key(:google_image_url)
          expect(data.first[:attributes]).to have_key(:zip_code)
          expect(data.first[:attributes]).to have_key(:summary)
          expect(data.first[:attributes]).to have_key(:goal)
          expect(data.first[:attributes]).to have_key(:availability_morning)
          expect(data.first[:attributes]).to have_key(:availability_afternoon)
          expect(data.first[:attributes]).to have_key(:availability_evening)
          expect(data.first[:attributes]).to have_key(:full_name)
        else
          expect(data).to be_empty
        end
      end
    end

    describe '.get_followers' do
      it "returns a hash with the user's followers if present" do
        actual = FriendshipService.get_followers(1)
        expect(actual).to be_a(Hash)
        expect(actual).to have_key(:data)

        data = actual[:data]
        expect(data).to be_an(Array)

        if data.size > 0
          expect(data).to all(have_key(:id))
          expect(data).to all(have_key(:type))
          expect(data).to all(have_key(:attributes))

          expect(data.first[:id]).to be_a(String)
          expect(data.first[:type]).to eq('user')
          expect(data.first[:attributes]).to be_a(Hash)

          expect(data.first[:attributes]).to have_key(:email)
          expect(data.first[:attributes]).to have_key(:google_id)
          expect(data.first[:attributes]).to have_key(:google_image_url)
          expect(data.first[:attributes]).to have_key(:zip_code)
          expect(data.first[:attributes]).to have_key(:summary)
          expect(data.first[:attributes]).to have_key(:goal)
          expect(data.first[:attributes]).to have_key(:availability_morning)
          expect(data.first[:attributes]).to have_key(:availability_afternoon)
          expect(data.first[:attributes]).to have_key(:availability_evening)
          expect(data.first[:attributes]).to have_key(:full_name)
        else
          expect(data).to be_empty
        end
      end
    end

    describe '.add_friend and .delete_friend' do
      it 'adds and deletes a friend' do
        uid = 2 # 1
        fid = 3 # 10

        params = {
          user_id: uid,
          followee_id: fid
        }

        expect(FriendshipService.add_friend(params).class).to eq(Hash)

        params = {
          user_id: uid,
          id: fid
        }

        actual = FriendshipService.delete_friend(params)
        expect(actual.env.url.to_s).to include("/api/v1/users/#{uid}/friendships/#{fid}")
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
