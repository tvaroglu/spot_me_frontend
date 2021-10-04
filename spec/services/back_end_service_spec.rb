require 'rails_helper'

describe BackEndService, :vcr, type: :service do
  describe 'class methods' do
    describe '.db_conn' do
      subject(:connection) { BackEndService.db_conn }

      it 'establishes a connection with the database endpoint' do
        expect(connection).to be_a(Faraday::Connection)
        expect(connection.url_prefix.to_s).to eq('https://spotme-app-api.herokuapp.com/')
      end
    end

    describe '.parse_json' do
      subject(:parsed_json) { BackEndService.parse_json(response) }

      let(:user_id) { '1' }
      let(:response) { BackEndService.db_conn.get("/api/v1/users/#{user_id}") }

      it 'returns the json response body' do
        expect(parsed_json).to be_a Hash
        expect(parsed_json[:data][:id]).to eq(user_id)
      end
    end
  end
end
