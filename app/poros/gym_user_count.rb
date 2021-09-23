class GymUserCount
  attr_reader :gym_member_count

  def initialize(info)
    @gym_member_count = info[:gym_member_count]
  end
end
