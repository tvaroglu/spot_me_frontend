require 'rails_helper'

RSpec.describe BackEndService do
  it 'can call a class method' do
    expect(BackEndService.hello).to eq 'world'
  end

  it 'can do other stuff' do
    # stuff
  end
end
