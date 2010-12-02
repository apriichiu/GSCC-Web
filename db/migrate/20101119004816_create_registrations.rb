class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.string :fullname
      t.string :address
      t.string :phone
      t.string :email
      t.string :church
      t.integer :payment_type
      t.integer :paid, :default => 0
      t.integer :guests, :default => 0
      t.string :guests_names
      t.string :guests_relation
      t.string :access_token
      t.string :password
      t.integer :event_id
      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
