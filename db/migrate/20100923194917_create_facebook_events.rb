class CreateFacebookEvents < ActiveRecord::Migration
  def self.up
    create_table :facebook_events do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.text :description
      t.datetime :updated_time
      t.string :identifier
      t.string :picture

      t.timestamps
    end
  end

  def self.down
    drop_table :facebook_events
  end
end
