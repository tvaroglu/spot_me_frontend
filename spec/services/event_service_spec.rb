require 'rails_helper'

describe EventService, :vcr, type: :service do
  describe 'class methods' do
    describe '.get_events' do
      context 'when the user exists' do
        subject(:user_events) { EventService.get_events(user_id) }

        let(:user_id) { 1 }

        it "returns a hash with the user's upcoming events" do
          expect(user_events).to be_a Hash
          expect(user_events).to have_key(:data)
          expect(user_events[:data]).to be_an Array

          expect(user_events[:data].first).to be_a Hash
          expect(user_events[:data].first).to have_key(:type)
          expect(user_events[:data].first[:type]).to be_a String
          expect(user_events[:data].first[:type]).to eq('event')

          expect(user_events[:data].first).to have_key(:meta)
          expect(user_events[:data].first[:meta]).to be_a Hash

          expect(user_events[:data].first[:meta]).to have_key(:friend_name)
          expect(user_events[:data].first[:meta][:friend_name]).to be_a String
          expect(user_events[:data].first[:meta]).to have_key(:friend_role)
          expect(user_events[:data].first[:meta][:friend_role]).to be_a String
          expect(user_events[:data].first[:meta]).to have_key(:gym_name)
          expect(user_events[:data].first[:meta][:gym_name]).to be_a String
          expect(user_events[:data].first[:meta]).to have_key(:yelp_gym_id)
          expect(user_events[:data].first[:meta][:yelp_gym_id]).to be_a String
        end
      end

      context 'when the user exists' do
        subject(:user_events) { EventService.get_events(user_id, 'past') }

        let(:user_id) { 1 }

        it "returns a hash with the user's past events" do
          expect(user_events).to be_a Hash
          expect(user_events).to have_key(:data)
          expect(user_events[:data]).to be_an Array

          expect(user_events[:data].first).to be_a Hash
          expect(user_events[:data].first).to have_key(:type)
          expect(user_events[:data].first[:type]).to be_a String
          expect(user_events[:data].first[:type]).to eq('event')

          expect(user_events[:data].first).to have_key(:meta)
          expect(user_events[:data].first[:meta]).to be_a Hash

          expect(user_events[:data].first[:meta]).to have_key(:friend_name)
          expect(user_events[:data].first[:meta][:friend_name]).to be_a String
          expect(user_events[:data].first[:meta]).to have_key(:friend_role)
          expect(user_events[:data].first[:meta][:friend_role]).to be_a String
          expect(user_events[:data].first[:meta]).to have_key(:gym_name)
          expect(user_events[:data].first[:meta][:gym_name]).to be_a String
          expect(user_events[:data].first[:meta]).to have_key(:yelp_gym_id)
          expect(user_events[:data].first[:meta][:yelp_gym_id]).to be_a String
        end
      end

      context 'when the user does not exist' do
        subject(:bad_user_events) { EventService.get_events(bad_user_id) }

        let(:bad_user_id) { 0 }

        it 'returns an error hash' do
          expect(bad_user_events).to be_a Hash

          expect(bad_user_events).to have_key(:message)
          expect(bad_user_events[:message]).to eq('your query could not be completed')

          expect(bad_user_events).to have_key(:errors)
          expect(bad_user_events[:errors]).to be_an Array
          expect(bad_user_events[:errors].size).to eq(1)
          expect(bad_user_events[:errors]).to eq(["Couldn't find User with 'id'=0"])
        end
      end
    end
  end
end
