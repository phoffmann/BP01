class Exam < ActiveRecord::Base
  has_many :exam_tasks
  has_many :tasks, :through => :exam_tasks

  has_many :exam_groups
  has_many :groups, :through => :exam_groups
end
