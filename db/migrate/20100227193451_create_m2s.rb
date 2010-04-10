class CreateM2s < ActiveRecord::Migration
  def self.up
    create_table :m2s do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :m2s
  end
end
