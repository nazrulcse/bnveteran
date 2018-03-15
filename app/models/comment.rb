# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  title            :string(50)       default("")
#  comment          :text
#  commentable_type :string
#  commentable_id   :integer
#  user_id          :integer
#  role             :string           default("comments")
#  created_at       :datetime
#  updated_at       :datetime
#  comment_html     :text
#

class Comment < ActiveRecord::Base
  include Shared::Callbacks
  include ActsAsCommentable::Comment
  include Mention

  belongs_to :commentable, polymorphic: true, counter_cache: true
  default_scope -> { order('created_at DESC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  # acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  has_many :notifications, as: :notification, dependent: :destroy

  # include PublicActivity::Model
  # tracked only: [:create], owner: proc { |_controller, model| model.user }

  validates_presence_of :comment
  validates_presence_of :commentable
  validates_presence_of :user

  auto_html_for :comment do
    image
    youtube(width: 400, height: 250, autoplay: true)
    link target: '_blank', rel: 'nofollow'
    simple_format
  end
end
