class CreateTaskKategories < ActiveRecord::Migration
  def self.up
    create_table :task_kategories do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :task_kategories
  end
end
