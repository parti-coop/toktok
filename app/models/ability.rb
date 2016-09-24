class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all do |model|
      !model.is_a?(Proposal)
    end
    can :create, Proposal
    if user
      can :create, [Comment, Participation]
      can :cancel, Participation
      can [:read, :update, :destroy], Proposal do |proposal|
        proposal.user == user
      end
    end
  end
end
