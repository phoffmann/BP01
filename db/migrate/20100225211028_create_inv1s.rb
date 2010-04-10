class CreateInv1s < ActiveRecord::Migration
  def self.up
    create_table :inv1s do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :inv1s
  end
end
