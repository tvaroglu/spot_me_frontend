class GymMembershipFacade
  def self.get_gym_memberships(user_id)
    gyms = GymMembershipService.get_gym_memberships(user_id)
    return [] unless gyms[:data]

    gyms[:data].map { |gym| GymMembership.new(gym) }
  end

  def self.get_gym_membership(params)
    response = GymMembershipService.get_gym_memberships(params[:user_id])
    return unless response[:data]

    gym_memberships = response[:data].map { |data| GymMembership.new(data) }
    gym_memberships.find do |gym_membership|
      gym_membership.yelp_gym_id == params[:yelp_gym_id]
    end
  end

  def self.create_gym_membership(gym_membership_params)
    GymMembershipService.create_gym_membership(gym_membership_params)
  end

  def self.delete_gym_membership(params)
    GymMembershipService.delete_gym_membership(params)
  end
end
