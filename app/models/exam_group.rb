class ExamGroup < ActiveRecord::Base
  belongs_to :exam
  belongs_to :group
end
