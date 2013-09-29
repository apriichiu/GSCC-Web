class AddFamilyAccomodationsToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :family_accomodations, :boolean
  end

  def self.down
    remove_column :registrations, :family_accomodations
  end
end
