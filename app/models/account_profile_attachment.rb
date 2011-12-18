class AccountProfileAttachment < ActiveRecord::Base
  field :file, :type => :string
  field :attachable_id, :type => :integer
  field :attachable_type, :type => :string
  field :content_type, :type => :string
  field :file_size, :type => :integer

  belongs_to :attachable, :polymorphic => true

  mount_uploader :file, FileUploader

  before_save :update_asset_attributes

  validates :file,
            :presence => false,
            :file_size => {
                :maximum => 1.megabytes.to_i
            }

  #to process each as images
  def is_image?
    true
  end

  def update_asset_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end

end

AccountProfileAttachment.auto_upgrade!