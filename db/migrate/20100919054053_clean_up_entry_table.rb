class CleanUpEntryTable < ActiveRecord::Migration
  def self.up
    remove_column :entries, :folder
    remove_column :entries, :attachment
  end

  def self.down
    add_column :entries, :folder, :string
    add_column :entries, :attachment, :string
  end
end
