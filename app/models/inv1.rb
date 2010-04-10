class Inv1 < ActiveRecord::Base
  has_one :task, :as => :resource

  attr_reader :message
  
  def check
    result = false
    @message = []

    if self.un == "mb"
      mat_a = Matice.new(ma).get_matrix
      if (mat_a != false) then
        if (mat_a.square?) then
          if (mat_a.regular?) then
            mat_b = mat_a.inverse
            #self.mb = mat_b.to_s.slice(7, mat_b.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, '][')
            result = true
          else
            @message << "Matice A musí být regulární."
          end
        else
          @message << "Matice A musí být čtvercová."
        end
      else
        @message << "Nesprávný zápis matice A."
      end
    end
    
    if self.un == "ma"
      mat_b = Matice.new(mb).get_matrix
      if (mat_b != false) then
        if (mat_b.square?) then
          if (mat_b.regular?) then
            mat_a = mat_b.inverse
            #self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, '][')
            result = true
          else
            @message << "Matice B musí být regulární."
          end
        else
          @message << "Matice B musí být čtvercová."
        end
      else
        @message << "Nesprávný zápis matice B."
      end
    end

    if result then
      if (mat_a.row_size > 1) then
        self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
        self.mb = mat_b.to_s.slice(7, mat_b.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
      else
        self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8)
        self.mb = mat_b.to_s.slice(7, mat_b.to_s.length - 8)
      end
    else
      if self.un == "ma"
        self.mb.gsub!(/\]\[/, "]\r\n[")
      end
      if self.un == "mb"
        self.ma.gsub!(/\]\[/, "]\r\n[")
      end
    end
    puts "Model Inv1"
    puts @message
    return result
  end

  def format_br(m)
    if(m == "ma") then
      return self.ma.gsub(/\s/, '').gsub(/\]\[/, "]<br>[")
    end
    if(m == "mb") then
      return self.mb.gsub(/\s/, '').gsub(/\]\[/, "]<br>[")
    end
  end

  def print_as_table(m, style_class = "")
    if m == "ma" then
      mt = self.ma
    else
      mt = self.mb
    end

    mt.gsub!(/[,]/, "</td><td>").gsub!(/[\[]/, "<tr><td>").gsub!(/[\]]/, "</td></tr>")
    if style_class != "" then
      mt = "<table class=\""+style_class+"\">"+mt+"</table>"
    else
      mt = "<table>"+mt+"</table>"
    end

    return mt

  end

end
