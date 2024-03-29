require 'rails_helper'

describe FriendshipFacade, type: :facade do
  describe '.get_friends' do
    context 'when the user has friends' do
      it "can return an array of the user's friends", :vcr do
        friends = FriendshipFacade.get_friends(1)

        expect(friends[0]).to be_an_instance_of(User)
        expect(friends).not_to be_empty
      end
    end

    context 'when the user does not have any friends' do
      it 'can return an empty array', :vcr do
        # friends = FriendshipFacade.get_friends(2)
        friends = FriendshipFacade.get_friends(3)

        expect(friends).to be_empty
      end
    end
  end

  describe '.get_followers' do
    context 'when the user has followers' do
      it "can return an array of the user's followers", :vcr do
        followers = FriendshipFacade.get_followers(1)

        expect(followers[0]).to be_an_instance_of(User)
        expect(followers).not_to be_empty
      end
    end

    context 'when the user does not have any followers' do
      it 'can return an empty array', :vcr do
        followers = FriendshipFacade.get_followers(11)

        expect(followers).to be_empty
      end
    end
  end
end
