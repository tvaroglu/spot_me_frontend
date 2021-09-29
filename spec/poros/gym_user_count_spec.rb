require 'rails_helper'

describe GymUserCount, type: :poro do
  describe 'object creation' do
    it 'initialize from given parameters params' do
      count = 15
      gym_member_count = { gym_member_count: count }
      gym_membership = GymUserCount.new(gym_member_count)

      expect(gym_membership).to be_an_instance_of(GymUserCount)
      expect(gym_membership.gym_member_count).to eq(count)
      expect(gym_membership.gym_member_count).to be_an Integer
    end
  end
end
