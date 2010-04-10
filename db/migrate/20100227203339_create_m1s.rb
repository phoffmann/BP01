class CreateM1s < ActiveRecord::Migration
  def self.up
    create_table :m1s do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :m1s
  end
end
