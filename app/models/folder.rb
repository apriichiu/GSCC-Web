class Folder < ActiveRecord::Base
  has_many :entries
  acts_as_textiled :description
end
