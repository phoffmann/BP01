class Group < ActiveRecord::Base
  has_many :exam_groups
  has_many :exams, :through => :exam_groups
  acts_as_tree :order => "name"

  def self.my_menu(parent_id)
    find(:all, :conditions => "parent_id="+ parent_id, :order => "name")
  end
end
