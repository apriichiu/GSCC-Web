class AddFieldsToTables < ActiveRecord::Migration
  def self.up
    add_column :entries, :verse, :string
    add_column :entries, :entry_date, :datetime
    add_column :entries, :tags, :string
    add_column :folders, :folder_type, :integer
  end

  def self.down
    remove_column :entries, :verse
    remove_column :entries, :entry_date
    remove_column :entries, :tags
    remove_column :folders, :folder_type
  end
end
