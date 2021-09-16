require 'rails_helper'

RSpec.describe BackEndService do
  it 'can retrieve the base url for API calls' do
    expect(BackEndService.base_url).to eq 'http://localhost/api/v1'
  end
end
