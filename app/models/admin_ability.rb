class AdminAbility
  include CanCan::Ability
  def initialize(user)
    if user and user.admin?
      can [:read, :manange], :all
    end
  end
end
