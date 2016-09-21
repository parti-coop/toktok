# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
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
    return '' if Rails.env.test?
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end
  version :xs, if: :image?  do
    process resize_to_fit: [80, nil]
  end

  version :sm, if: :image? do
    process resize_to_fit: [200, nil ]
  end

  version :md, if: :image? do
    process resize_to_fit: [400, nil]
  end

  version :lg, if: :image? do
    process resize_to_fit: [700, nil]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  # def url
  #   (AttachmentUploader::env_storage == :fog or self.file.try(:exists?)) ? super : "https://hotline-file.s3.amazonaws.com#{super}"
  # end

  before :cache, :save_original_filename
  def save_original_filename(file)
    model.name ||= file.original_filename.unicode_normalize if file.respond_to?(:original_filename)
  end

  protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end
end
