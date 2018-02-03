class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :login, :password, :password_confirmation, :remember_me
  
  attr_accessor :login
  mount_uploader :photo, AvatarUploader

  def super_admin?
    role == 'Super_admin'
  end
  
  protected
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(email) = :value", { :value => login.strip.downcase }]).first
  end

end
