class AddRegOptionToEvents < ActiveRecord::Migration
  def self.up
    add_column :facebook_events, :reg, :boolean, :default => 0
  end

  def self.down
    remove_column :facebook_events, :reg
  end
end
