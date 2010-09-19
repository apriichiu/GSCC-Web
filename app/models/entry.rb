class Entry < ActiveRecord::Base
belongs_to :folder

has_many :attachments

end
