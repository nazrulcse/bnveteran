class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  #include CarrierWave::MimeTypes
  # include CarrierWave::MiniMagick

  # Call method
  #process :set_content_type

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  if Rails.env.test? or Rails.env.cucumber?
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end
  version :large, :if => :image? do
    process :resize_to_fit => [400, 400]
  end

  version :thumb, :if => :image? do
    process :resize_to_fit => [100, 100]
  end

  version :small, :if => :image? do
    process :resize_to_fit => [50, 50]
  end

  version :fullscreen, :if => :image? do
    process :resize_to_fit => [1200, 296]
  end

  def cover
    manipulate! do |frame, index|
      frame if index.zero?
    end
  end

  version :small_thumb_pdf, :if => :pdf? do
    process :cover
    process :resize_to_fill => [50, 25]
    process :convert => :jpg

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.jpg'
    end
  end

  version :medium_thumb_pdf, :if => :pdf? do
    process :cover
    process :resize_to_fill => [100, 50]
    process :convert => :jpg

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.jpg'
    end
  end

  version :large_thumb_pdf, :if => :pdf? do
    process :cover
    process :resize_to_fill => [400, 400]
    process :convert => :jpg

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.jpg'
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png pdf doc docx)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  protected
  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def pdf?(new_file)
    new_file.content_type.include? 'pdf'
  end
end