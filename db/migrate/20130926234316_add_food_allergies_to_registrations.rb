class AddFoodAllergiesToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :food_allergies, :text
  end

  def self.down
    remove_column :registrations, :food_allergies
  end
end
