class GymMembership
  attr_reader :id, :gym_name, :yelp_gym_id

  def initialize(data)
    @id = data[:id]
    return unless data[:attributes]

    @gym_name = data[:attributes][:gym_name]
    @yelp_gym_id = data[:attributes][:yelp_gym_id]
  end
end
