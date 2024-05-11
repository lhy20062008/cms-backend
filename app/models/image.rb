class Image < ApplicationRecord
  validates :image, presence: true
  belongs_to :target, polymorphic: true, required: false, touch: true
  mount_uploader :image, ImageUploader

  default_scope -> { order('images.ranking desc nulls last') }
end
