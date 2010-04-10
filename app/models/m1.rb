class M1 < ActiveRecord::Base
  has_one :task, :as => :resource

  attr_reader :message

  def check
    result = false
    @message = []
    
    mat_a = Matice.new(ma).get_matrix

    if(mat_a != false) then
      #self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, '][')
      self.n = mat_a.rank
      result = true
    else
      if mat_a == false then
        @message << "Nesprávný zápis matice A."
      end
    end

    puts mat_a

    if result then
      if mat_a.row_size > 1 then
        self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
      else
        self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8)
        puts "001"
        puts mat_a.to_s.slice(7, mat_a.to_s.length - 8)
        puts "002"
        mat_a.to_s.slice(7, mat_a.to_s.length - 8).to_s.gsub!(/\s/, '')
      end
    end
    puts self.ma
    puts "Model M1"
    puts @message
    return result

  end
  
  def format_br(m)
    if(m == "ma") then
      return self.ma.gsub(/\s/, '').gsub(/\]\[/, "]<br>[")
    end
  end

  def print_as_table(m, style_class = "")
    if m == "ma" then
      mt = self.ma
      mt.gsub!(/[,]/, "</td><td>").gsub!(/[\[]/, "<tr><td>").gsub!(/[\]]/, "</td></tr>")
      if style_class != "" then
        mt = "<table class=\""+style_class+"\">"+mt+"</table>"
      else
        mt = "<table>"+mt+"</table>"
      end
    else
        mt = "<table><tr><td>Neodpovězeno.</td></tr></table>"
    end


    return mt

  end

end
