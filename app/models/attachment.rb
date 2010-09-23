class Attachment < ActiveRecord::Base

  belongs_to :entry
  has_attached_file :object, :styles => {:thumbnail => "50x50", :small => "150x150"},
                    :path => ":rails_root/public/assets/:id/:basename_:style.:extension",
                    :url => "/assets/:id/:basename_:style.:extension"
  

  before_post_process :is_image?

  def is_image?
    !(object_content_type =~ /^image.*/).nil?
  end

 validates_attachment_presence :object
# validates_attachment_size :photo, :less_than => 5.megabytes
# validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

end
