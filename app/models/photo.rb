class Photo < ActiveRecord::Base
  mount_uploader :media, PhotoFileUploader

  validates :media, presence: true
end
