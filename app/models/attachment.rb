class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  mount_uploader :source, AttachmentUploader

  before_save :update_source_attributes

  private

  def update_source_attributes
    if source.present? && source_changed?
      self.source_type = source.file.content_type
    end
  end
end
