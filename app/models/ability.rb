class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can :create, [Comment, Proposal]
    end
  end
end
