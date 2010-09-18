class Attachment < ActiveRecord::Base

  has_attached_file :object

  before_post_process :is_image?

  def is_image?
    !(object_content_type =~ /^image.*/).nil?
  end


# has_attached_file :photo, :styles => { :small => "150x150>" },
#                   :url  => "/assets/products/:id/:style/:basename.:extension",
#                   :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

 validates_attachment_presence :object
# validates_attachment_size :photo, :less_than => 5.megabytes
# validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

end
