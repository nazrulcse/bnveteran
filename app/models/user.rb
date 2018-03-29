# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           default(""), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  about                  :string
#  avatar                 :string
#  cover                  :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  sex                    :string           default("male"), not null
#  location               :string
#  dob                    :date
#  phone_number           :string
#  posts_count            :integer          default(0), not null
#  slug                   :string
#  sash_id                :integer
#  level                  :integer          default(0)
#  designation_type       :integer
#  rank                   :integer
#  officer_no             :string
#  date_joining           :date
#  date_retirement        :date
#  batch                  :string
#  address                :string
#  state                  :string
#  city                   :string
#  country                :string
#  permanent_address      :string
#  present_address        :string
#  avatar_pdf             :string
#  present_state          :string
#  present_city           :string
#  present_country        :string
#  status                 :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  has_merit
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_voter
  acts_as_follower
  acts_as_followable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :admin_messages

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader
  mount_uploader :avatar_pdf, AvatarUploader

  validates_presence_of :name, :rank
  validates_uniqueness_of :officer_no

  self.per_page = 25

  extend FriendlyId
  friendly_id :user_slug, use: [:slugged, :finders]
  attr_accessor :login


  OFFICER = [
      ["Admiral of the Fleet",1],
      ["Admiral",2],
      ["Vice Admiral",3],
      ["Rear Admiral",4],
      ["Commodore",5],
      ["Captain",6],
      ["Commander",7],
      ["Lieutenant Commander",8],
      ["Lieutenant",9],
      ["Sub Lieutenant",10],
      ["Acting Sub Lieutenant",11],
      ["Midshipman",12]
  ]

  DESIGNATION_TYPE = [["Officer",1],["JCO & Others",2]]

  JCO =[
      ["Master Chief Petty Officer",13],
      ["Senior Chief Petty Officer or Equivalent",14],
      [ "Chief Petty Officer or Equivalent",15],
      [ "Petty Officer or Equivalent",16],
      [ "Leading Seaman or Equivalent",17],
      [ "Able Seaman or Equivalent",18],
      ["Ordinary Seaman",19],
      ["Master Warrant Officer",20],
      ["Senior Warrant Officer",21],
      ["Warrant Officer",22],
      ["Sergeant",23],
      ["Corporal",24],
      ["Lance Corporal",25],
      ["Sainik",26]
  ]

  RANK = [
      ["Admiral of the Fleet",1],
      ["Admiral",2],
      ["Vice Admiral",3],
      ["Rear Admiral",4],
      ["Commodore",5],
      ["Captain",6],
      ["Commander",7],
      ["Lieutenant Commander",8],
      ["Lieutenant",9],
      ["Sub Lieutenant",10],
      ["Acting Sub Lieutenant",11],
      ["Midshipman",12],
      ["Master Chief Petty Officer",13],
      ["Senior Chief Petty Officer or Equivalent",14],
      [ "Chief Petty Officer or Equivalent",15],
      [ "Petty Officer or Equivalent",16],
      [ "Leading Seaman or Equivalent",17],
      [ "Able Seaman or Equivalent",18],
      ["Ordinary Seaman",19],
      ["Master Warrant Officer",20],
      ["Senior Warrant Officer",21],
      ["Warrant Officer",22],
      ["Sergeant",23],
      ["Corporal",24],
      ["Lance Corporal",25],
      ["Sainik",26]
  ]

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(officer_no) = :value OR lower(email) = :value", { :value  =>  login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  def full_present_address
    [present_address.present? ? present_address : nil, present_city.present? ? present_city : nil, present_state.present? ? present_state : nil, present_country.present? ? present_country : nil].compact.join(', ')
  end

  def full_permanent_address
    [permanent_address.present? ? permanent_address : nil, city.present? ? city : nil, state.present? ? state : nil, country.present? ? country : nil].compact.join(', ')
  end

  def self.search(value)
    where('name ILIKE :q OR email ILIKE :q OR phone_number ILIKE :q OR officer_no ILIKE :q', q: "%#{value}%").where(status: true)
  end

  def self.topic_creator_image(notification)
    if notification.present?
      notifier = User.find_by(id: notification.topic_creator_id)
      if notifier.present?
        notifier.avatar
      end
    end
  end

  def user_slug
    users = User.where(name: name)
    if users.present?
      name + '-' + users.count.to_s
    else
      name
    end
  end

end
