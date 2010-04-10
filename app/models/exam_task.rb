class ExamTask < ActiveRecord::Base
  belongs_to :exam
  belongs_to :task
end
