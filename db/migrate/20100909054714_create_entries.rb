class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|

      t.string :topic

      t.string :series

      t.date :date

      t.text :verse


      t.timestamps

    end
  end

  def self.down
    drop_table :entries
  end
end
