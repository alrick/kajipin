class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    ##### USER
    # User can manage himself
    can :manage, User, :id => user.id
    # User can read users(profile) that are sharing with him
    can :read, User do |u|
      if user.instance_of?(User)
        u.isSharingWith(user)
      elsif user.instance_of?(Herald)
        user.user == u
      end
    end

    ##### PIN
    # User can manage pins he owns
    can :manage, Pin do |p|
      p.user == user
    end
    # User can read pins of users that are sharing with him
    can :read, Pin do |p|
      if user.instance_of?(User)
        p.user.isSharingWith(user)
      elsif user.instance_of?(Herald)
        user.user == p.user
      end
    end

    ##### PHOTO
    # User can manage and create photos he owns
    can :manage, Photo do |p|
      p.pin.user == user
    end
    
    ##### COMMENT
    # User can manage comments in pins he owns
    can :manage, Comment do |c|
      c.pin.user == user
    end
    # User can create comments on pins of users that are sharing with him
    can :create, Comment do |c|
      c.pin.user.isSharingWith(user)
    end

    ##### FRIENDSHIP
    # User can read friendships he is part of 
    can :read, Friendship, :user_id => user.id
    can :read, Friendship, :friend_id => user.id
    # User can create or destroy a friendship if he is the owner
    can :create, Friendship, :user_id => user.id
    can :destroy, Friendship, :user_id => user.id

    ##### REQUEST
    # User can read requests he is part of
    can :read, Request, :user_id => user.id
    can :read, Request, :requester_id => user.id
    # User can create a request if he is the requester
    can :create, Request, :requester_id => user.id
    # User can destroy and approve a request if he is the owner
    can :destroy, Request, :user_id => user.id
    can :approve, Request, :user_id => user.id

    ##### AVATAR
    # User can manage his avatar
    can :manage, Avatar, :user_id => user.id

    ##### HERALD
    # User can manage his herald
    can :manage, Herald, :user_id => user.id
    can :show, Herald
    can :photos, Herald
    can :logpages, Herald
    can :comments, Herald
  end
end
