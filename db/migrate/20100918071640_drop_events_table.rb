class DropEventsTable < ActiveRecord::Migration
  def self.up
    drop_table :events
  end

  def self.down
    create_table :events do |t|
      t.string :title
      t.string :description
      t.text :page
      t.datetime :startdate
      t.string :location

      t.timestamps
    end
  end
end
