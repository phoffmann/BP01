class Task < ActiveRecord::Base
  has_many :exam_tasks
  has_many :exams, :through => :exam_tasks
  belongs_to :resource, :polymorphic => true
end
