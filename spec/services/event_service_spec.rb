require 'rails_helper'

describe EventService, :vcr, type: :service do
  describe 'class methods' do
    describe '.get_upcoming_events' do
      context 'when the user exists' do
        subject(:user_events) { EventService.get_upcoming_events(user_id) }

        let(:user_id) { 1 }

        it "returns the user's upcoming events" do
          expect(user_events).to be_a Hash
          expect(user_events).to have_key(:data)
          expect(user_events[:data]).to be_an Array

          expect(user_events[:data].first).to be_a Hash
          expect(user_events[:data].first).to have_key(:type)
          expect(user_events[:data].first[:type]).to be_a String
          expect(user_events[:data].first[:type]).to eq('event')

          expect(user_events[:data].first).to have_key(:relationships)
          expect(user_events[:data].first[:relationships]).to be_a Hash

          expect(user_events[:data].first[:relationships]).to have_key(:user)
          expect(user_events[:data].first[:relationships][:user]).to be_a Hash

          expect(user_events[:data].first[:relationships][:user]).to have_key(:meta)
          expect(user_events[:data].first[:relationships][:user][:meta]).to be_a Hash

          expect(user_events[:data].first[:relationships][:user][:meta]).to have_key(:full_name)
          expect(user_events[:data].first[:relationships][:user][:meta][:full_name]).to be_a String
        end
      end

      context 'when the user does not exist' do
        subject(:bad_user_events) { EventService.get_upcoming_events(bad_user_id) }

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
