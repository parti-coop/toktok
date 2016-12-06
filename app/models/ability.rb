class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all do |model|
      !model.is_a?(Proposal)
    end
    can [:thanks, :create], Proposal
    can [:search], Project
    if user
      can [:create, :update, :destroy], Participation
      can [:create, :update, :destroy], Comment do |comment|
        comment.user == user
      end
      can :cancel, Participation
      can [:read, :update, :destroy], Proposal do |proposal|
        proposal.user == user
      end
    end
  end
end
