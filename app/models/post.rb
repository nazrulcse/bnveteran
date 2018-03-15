# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  content         :text             not null
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  cached_votes_up :integer          default(0)
#  comments_count  :integer          default(0)
#  content_html    :text
#  attachments     :text
#  is_share        :boolean          default(FALSE)
#  shared_id       :integer
#  share_count     :integer          default(0)
#  slug            :string
#

class Post < ActiveRecord::Base
  include Shared::Callbacks
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content

  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  has_many :notifications, as: :notification, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_many :shares, class_name: 'Post', foreign_key: :shared_id, dependent: :destroy
  belongs_to :shared, class_name: 'Post', foreign_key: :shared_id
  counter_culture :user
  acts_as_votable
  acts_as_commentable

  include PublicActivity::Model
  tracked only: [:create, :like], owner: proc { |_controller, model| model.user }

  default_scope -> { order('created_at DESC') }

  mount_uploader :attachments, AvatarUploader

  #validates_presence_of :content
  validates_presence_of :user

  auto_html_for :content do
    image
    youtube(width: 400, height: 250, autoplay: true)
    link target: '_blank', rel: 'nofollow'
    simple_format
  end

  # extend FriendlyId
  # friendly_id :post_slug, use: [:slugged, :finders]

  extend FriendlyId
  friendly_id :generated_slug, use: [:slugged, :finders]

  def generated_slug
    require 'securerandom'
    @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(15)
  end


  # hashtags counting....
  after_create :update_hashtags, :increase_share_count
  after_destroy :decrease_share_count

  def increase_share_count
    if is_share
      post_share_count = shared.share_count + 1
      shared.update_attributes(share_count: post_share_count)
    end
  end

  def decrease_share_count
    if is_share
      post_share_count = shared.share_count - 1
      shared.update_attributes(share_count: post_share_count)
    end
  end

  def update_hashtags
    hashtag_regex = /(?:\s|^)(#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$))([a-z0-9\-_]+))/i
    text_content = Nokogiri::HTML(content).xpath('//text()').map(&:text).join(' ')
    text_hashtags = text_content.scan(hashtag_regex)

    text_hashtags.each do |tag|
      hash_tag = SimpleHashtag::Hashtag.find_by_name(tag[0])
      if hash_tag.present?
        if self.id
          hashtagging = SimpleHashtag::Hashtagging.where(hashtag_id: hash_tag.id, hashtaggable_type: 'Post', hashtaggable_id: self.id).first
          unless hashtagging.present?
            SimpleHashtag::Hashtagging.create(hashtag_id: hash_tag.id, hashtaggable_type: 'Post', hashtaggable_id: self.id)
          end
        end
      else
        SimpleHashtag::Hashtag.create name: tag[0]
      end
    end
  end
  # hashtags counting end....


  # after_create :process_hashtags
  #
  # def process_hashtags
  #   hashtag_regex = /\B#\w\w+/
  #   text_hashtags = content.scan(hashtag_regex)
  #   text_hashtags.each do |tag|
  #     hashtags.create name: tag
  #   end
  # end

  def self.search(value)
    where('content ILIKE :q', q: "%#{value}%")
  end

end
