class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Pin, :user_id => user.id
    can :manage, User, :id => user.id
    can :manage, Logpage
    can :manage, Comment
    can :manage, Friendship, :user_id => user.id
    can :manage, Friendship, :friend_id => user.id
  end
end
