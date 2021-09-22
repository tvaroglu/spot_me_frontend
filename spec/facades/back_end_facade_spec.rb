require 'rails_helper'

RSpec.describe BackEndFacade do
  describe '.get_user_friends' do
    context 'when the user has friends' do
      it "can return an array of the user's friends", :vcr do
        friends = BackEndFacade.get_user_friends(1)

        expect(friends[0]).to be_an_instance_of(User)
        expect(friends).not_to be_empty
      end
    end

    context 'when the user does not have any friends' do
      it 'can return an empty array', :vcr do
        friends = BackEndFacade.get_user_friends(2)

        expect(friends).to be_empty
      end
    end
  end

  describe '.get_user_gyms' do
    context 'when the user has gyms' do
      it "can return an array of the user's gyms", :vcr do
        gyms = BackEndFacade.get_user_gyms(1)

        expect(gyms[0]).to be_an_instance_of(UserGym)
        expect(gyms).not_to be_empty
      end
    end

    context 'when the user does not have any gyms' do
      it 'can return an empty array', :vcr do
        gyms = BackEndFacade.get_user_gyms(11)

        expect(gyms).to be_empty
      end
    end
  end

  describe'.get_user_events' do
    context 'when the user has events' do
      it "can return an array of the user's workouts", :vcr do
        events = BackEndFacade.get_user_events(1)

        expect(events[0]).to be_an_instance_of(UserEvent)
        expect(events).not_to be_empty
      end
    end

    context 'when the user does not have any events' do
      it 'can return an empty array', :vcr do
        events = BackEndFacade.get_user_events(2)

        expect(events).to be_empty
      end
    end
  end

  # it 'can find gyms near a user' do
  #   gyms = BackEndFacade.searched_gyms(30340)
  #   expect(gyms[0]).to be_an_instance_of(YelpGym)
  #   expect(gyms.count).to eq(20)
  # end
end
