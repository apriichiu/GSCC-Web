class ChangeStartdateColumn < ActiveRecord::Migration
  def self.up
    change_column :events, :startdate, :datetime
  end

  def self.down
    change_column :events, :startdate, :time
  end
end
