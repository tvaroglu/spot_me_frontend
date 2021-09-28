require 'rails_helper'

describe FriendshipService, type: :service do
  it 'can parse friendships json', :vcr do
    expect(FriendshipService.get_friends(1).class).to eq(Hash)
  end

  it 'can parse friendship creation json', :vcr do
    params = {
      user_id: 1,
      followee_id: 10
    }
    expect(FriendshipService.add_friend(params).class).to eq(Hash)
  end

  it 'can parse a gyms friends of the current user', :vcr do
    expect(FriendshipService.get_friends_at_gym('BJBXzKYxQAXZKb5W6HrRnA', 1)).to be_a(Hash)
  end

  it 'can parse a gyms non friends of the current user', :vcr do
    params = { yelp_gym_id: 'BJBXzKYxQAXZKb5W6HrRnA', user_id: 1 }
    expect(FriendshipService.get_non_friends_at_gym(params)).to be_a(Hash)
  end
end
