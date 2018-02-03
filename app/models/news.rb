class News < ApplicationRecord

  validates_presence_of :title, :photo

  mount_uploader :photo, AvatarUploader

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def is_pdf?
    photo.path.downcase.end_with?('.pdf')
  end

  def is_doc?
    photo.path.downcase.end_with?('.doc') || photo.path.downcase.end_with?('.docx')
  end

  def doc_url(host)
    "#{host}#{photo.url}"
  end

end
