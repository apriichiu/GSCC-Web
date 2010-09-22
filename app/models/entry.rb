class Entry < ActiveRecord::Base
  belongs_to :folder
  has_many :attachments
  acts_as_textiled :description
end
