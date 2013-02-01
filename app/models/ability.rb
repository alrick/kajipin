class Ability
  include CanCan::Ability

  def initialize(user)
    # User can manage pins he owns
    can :manage, Pin, :user_id => user.id

    # User can manage himself
    can :manage, User, :id => user.id

    # User can manage logpages he owns
    can :manage, Logpage do |l|
      l.pin.user == user
    end

    # User can manage comments he owns
    can :manage, Comment do |c|
      c.pin.user == user
    end

    # User can read users(profile) that are sharing with him
    can :read, User do |u|
      u.isSharingWith(user)
    end

    # User can read pins of users that are sharing with him (includes logpage and comments)
    can :read, Pin do |p|
      p.user.isSharingWith(user)
    end

    # User can create comments on pins of users that are sharing with him
    can :create, Comment do |c|
      c.pin.user.isSharingWith(user)
    end

    # User can read friendships he is part of 
    can :read, Friendship, :user_id => user.id
    can :read, Friendship, :friend_id => user.id

    # User can create or destroy a friendship if he is the owner
    can :create, Friendship, :user_id => user.id
    can :destroy, Friendship, :user_id => user.id

  end
end
