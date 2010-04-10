class TaskKategory < ActiveRecord::Base

  def self.as_assoc_ar
    tk = find(:all)
    ar = tk.inject({}) do |result, element|
      result[element.name] = element.desc
      result
    end
    return ar
  end
end
