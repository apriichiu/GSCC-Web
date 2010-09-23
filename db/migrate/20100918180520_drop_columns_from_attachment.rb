class DropColumnsFromAttachment < ActiveRecord::Migration
  def self.up
    remove_column :attachments, :type
    remove_column :attachments, :size
    remove_column :attachments, :file
    remove_column :attachments, :date
    add_column :attachments, :description, :string
  end

  def self.down
    add_column :attachments, :type, :string
    add_column :attachments, :size, :integer
    add_column :attachments, :file, :string
    add_column :attachments, :date, :date
    remove_column :attachments, :description
  end
end
