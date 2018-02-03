module FollowsHelper


  def un_friends
    friends = current_user.all_following.unshift(current_user)
    User.where(status: true).where.not(id: friends).limit(7)
  end

end
