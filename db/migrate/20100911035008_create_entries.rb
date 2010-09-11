class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|

      t.string :folder

      t.string :title

      t.text :description

      t.string :attachment


      t.timestamps

    end
  end

  def self.down
    drop_table :entries
  end
end
