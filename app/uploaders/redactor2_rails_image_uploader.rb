# encoding: utf-8
class Redactor2RailsImageUploader < CarrierWave::Uploader::Base
  include Redactor2Rails::Backend::CarrierWave
  include CarrierWave::MiniMagick

  def self.env_storage
    if Rails.env.production?
      :fog
    else
      :file
    end
  end

  storage env_storage

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/redactor2_assets/images/#{model.class.to_s.underscore}/#{model.id}"
  end

  def content_type_whitelist
    /image\//
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process :read_dimensions

  version :xs  do
    process resize_to_fit: [80, nil]
  end

  version :sm do
    process resize_to_fit: [200, nil]
  end

  version :md do
    process resize_to_fit: [400, nil]
  end

  version :lg do
    process resize_to_fit: [700, nil]
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  version :content do
    process :resize_to_limit => [800, 800]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    Redactor2Rails.images_file_types
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
