class GymUserCount
  attr_reader :gym_member_count

  def initialize(data)
    @gym_member_count = data[:gym_member_count]
  end
end
