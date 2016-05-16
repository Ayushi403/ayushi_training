class Image < ActiveRecord::Base
belongs_to :imageable, polymorphic: true
mount_uploader :image_url, AvatarUploader
validates :image_url, presence: true
validates :image_url, format: {
with:
%r{\.(gif|jpg|png)$}i,
message: 'must be a URL for GIF, JPG or PNG image.'
}
end
