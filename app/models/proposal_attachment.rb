class ProposalAttachment < ApplicationRecord
  belongs_to :proposal

  mount_uploader :source, AttachmentUploader

  before_save :update_source_attributes

  private

  def update_source_attributes
    if source.present? && source_changed?
      self.source_type = source.file.content_type
    end
  end
end
