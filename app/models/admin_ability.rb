class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user and user.role.staff?
      can :manage, :all
    end
  end
end
