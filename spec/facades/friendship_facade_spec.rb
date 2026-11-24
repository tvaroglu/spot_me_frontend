require 'rails_helper'

describe FriendshipFacade, type: :facade do
  describe '.get_friends' do
    it "can return an array of the user's friends if present", :vcr do
      friends = FriendshipFacade.get_friends(1)

      expect(friends).to be_an(Array)
      if friends.size > 0
        expect(friends[0]).to be_an_instance_of(User)
      else
        expect(friends).to be_empty
      end
    end

    it 'can return an empty array if no friends present', :vcr do
      friends = FriendshipFacade.get_friends(0)

      expect(friends).to be_empty
    end
  end

  describe '.get_followers' do
    it "can return an array of the user's followers if present", :vcr do
      followers = FriendshipFacade.get_followers(1)

      expect(followers).to be_an(Array)
      if followers.size > 0
        expect(followers[0]).to be_an_instance_of(User)
      else
        expect(followers).to be_empty
      end
    end

    it 'can return an empty array if no followers present', :vcr do
      followers = FriendshipFacade.get_followers(0)

      expect(followers).to be_empty
    end
  end
end
