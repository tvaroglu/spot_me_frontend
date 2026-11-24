require 'rails_helper'

describe EventService, :vcr, type: :service do
  describe 'class methods' do
    describe '.get_events' do
      context 'when the user exists' do
        let(:user_id) { 1 }
        let(:upcoming_events) { EventService.get_events(user_id) }
        let(:past_events) { EventService.get_events(user_id, 'past') }

        it "returns a hash with the user's upcoming events if present" do
          expect(upcoming_events).to be_a Hash
          expect(upcoming_events).to have_key(:data)

          data = upcoming_events[:data]
          expect(data).to be_an Array

          if data.size > 0
            expect(data.first).to be_a Hash
            expect(data.first).to have_key(:type)
            expect(data.first[:type]).to be_a String
            expect(data.first[:type]).to eq('event')

            expect(data.first).to have_key(:meta)
            expect(data.first[:meta]).to be_a Hash

            expect(data.first[:meta]).to have_key(:friend_name)
            expect(data.first[:meta][:friend_name]).to be_a String
            expect(data.first[:meta]).to have_key(:friend_role)
            expect(data.first[:meta][:friend_role]).to be_a String
            expect(data.first[:meta]).to have_key(:gym_name)
            expect(data.first[:meta][:gym_name]).to be_a String
            expect(data.first[:meta]).to have_key(:yelp_gym_id)
            expect(data.first[:meta][:yelp_gym_id]).to be_a String
          else
            expect(data).to be_empty
          end
        end

        it "returns a hash with the user's past events if present" do
          expect(past_events).to be_a Hash
          expect(past_events).to have_key(:data)

          data = past_events[:data]
          expect(data).to be_an Array

          if data.size > 0
            expect(data.first).to be_a Hash
            expect(data.first).to have_key(:type)
            expect(data.first[:type]).to be_a String
            expect(data.first[:type]).to eq('event')

            expect(data.first).to have_key(:meta)
            expect(data.first[:meta]).to be_a Hash

            expect(data.first[:meta]).to have_key(:friend_name)
            expect(data.first[:meta][:friend_name]).to be_a String
            expect(data.first[:meta]).to have_key(:friend_role)
            expect(data.first[:meta][:friend_role]).to be_a String
            expect(data.first[:meta]).to have_key(:gym_name)
            expect(data.first[:meta][:gym_name]).to be_a String
            expect(data.first[:meta]).to have_key(:yelp_gym_id)
            expect(data.first[:meta][:yelp_gym_id]).to be_a String
          else
            expect(data).to be_empty
          end
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
