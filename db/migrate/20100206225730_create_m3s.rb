class CreateM3s < ActiveRecord::Migration
  def self.up
    create_table :m3s do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :m3s
  end
end
