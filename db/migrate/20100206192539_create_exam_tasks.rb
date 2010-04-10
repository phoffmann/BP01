class CreateExamTasks < ActiveRecord::Migration
  def self.up
    create_table :exam_tasks do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :exam_tasks
  end
end
