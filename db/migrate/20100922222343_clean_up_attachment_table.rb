class CleanUpAttachmentTable < ActiveRecord::Migration
  def self.up
    remove_column :attachments, :name
    remove_column :attachments, :description
  end

  def self.down
    add_column :attachments, :name, :string
    add_column :attachments, :description, :string
  end
end
