class AddingTableRelations < ActiveRecord::Migration
  def self.up
    add_column :attachments, :entry_id, :integer
    add_column :entries, :folder_id, :integer
  end

  def self.down
    remove_column :attachments, :entry_id
    remove_column :entries, :folder_id
  end
end
