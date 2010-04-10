class CreateExamGroups < ActiveRecord::Migration
  def self.up
    create_table :exam_groups do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :exam_groups
  end
end
