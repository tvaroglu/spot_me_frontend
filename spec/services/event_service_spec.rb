require 'rails_helper'

describe EventService, type: :service do
  it 'can parse workout events json', :vcr do
    expect(EventService.get_events(1).class).to eq(Hash)
  end
end
