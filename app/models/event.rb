# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  name            :string
#  event_datetime  :datetime
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  cached_votes_up :integer          default(0)
#  comments_count  :integer          default(0)
#  photo           :string
#  description     :text
#

class Event < ActiveRecord::Base
  include Shared::Callbacks
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  acts_as_votable
  acts_as_commentable

  include PublicActivity::Model
  tracked only: [:create, :like], owner: Proc.new{ |controller, model| model.user }

  validates_presence_of :name
  validates_presence_of :event_datetime
  validates_presence_of :user

  mount_uploader :photo, AvatarUploader

end
