# == Schema Information
#
# Table name: abilities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ability < ApplicationRecord
  include CanCan::Ability


  def initialize(admin_user)
    admin_user ||= AdminUser.new # guest user (not logged in)
    if admin_user.super_admin?
      can :manage, :all
    else
      can :read, :all
      can :create, AdminMessage
      can :manage, Facility
      can :manage, FacilityForm
      can :manage, NotificationImage
      can :manage, GalleryPhoto
      can :manage, Album
      can :manage, PageBanner
      can :manage, News
      can :manage, User
    end
  end

  # def initialize(user)
  #   can :manage, Post
  #   can :read, User
  #   can :manage, User, id: user.id
  #   can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: :admin
  # end

end
