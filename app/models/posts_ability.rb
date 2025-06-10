class PostsAbility
  include CanCan::Ability

  def initialize(user)
    if user.present? && user.is_admin?
      can :manage, Post
      can :manage, :admin_posts
    end
  end
end
