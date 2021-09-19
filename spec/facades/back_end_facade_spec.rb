require 'rails_helper'

RSpec.describe BackEndFacade do

  it 'can create an array of user friends' do
    friends = BackEndFacade.get_user_friends(1)
    expect(friends[0]).to be_an_instance_of(User)
    expect(friends.count).to eq(3)
  end

  it 'can create an array of user gyms' do
    gyms = BackEndFacade.get_user_gyms(1)
    expect(gyms[0]).to be_an_instance_of(UserGym)
    expect(gyms.count).to eq(3)
  end

  it 'can find gyms near a user' do
    gyms = BackEndFacade.searched_gyms(30340)
    expect(gyms[0]).to be_an_instance_of(YelpGym)
    expect(gyms.count).to eq(20)
  end

  it 'can create an array of workout events' do
    events = BackEndFacade.get_user_events(1)
    expect(events[0]).to be_an_instance_of(UserEvent)
    expect(events.count).to eq(3)
  end
end
