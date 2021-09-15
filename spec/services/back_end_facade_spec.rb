require 'rails_helper'

RSpec.describe BackEndFacade do
  it 'can call a class method' do
    expect(BackEndFacade.hello).to eq 'world'
  end
end
