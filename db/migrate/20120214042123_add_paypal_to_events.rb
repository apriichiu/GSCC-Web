class AddPaypalToEvents < ActiveRecord::Migration
  def self.up
    add_column :facebook_events, :paypal, :text
  end

  def self.down
    remove_column :facebook_events, :paypal
  end
end
