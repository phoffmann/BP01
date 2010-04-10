class M2 < ActiveRecord::Base
  has_one :task, :as => :resource

  attr_reader :message

  def check
    result = false
    @message = []

    if self.un == "ma"
      mat_b = Matice.new(mb).get_matrix
      n = self.n.to_s
      n.gsub!(/\s/, '')

      if(mat_b != false && (n.index(/^[-]{0,1}[0-9]{1,}$/) != nil || n.index(/^[-]{0,1}[0-9]{1,}[\/]{1}[-]{0,1}[1-9]{1,}[0-9]{0,}$/) != nil)) then
        puts "kontrola"
        self.n = n.to_i
        mat_a = mat_b / self.n
        #self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, '][')
        result = true
      else
        if mat_b == false then
          @message << "Nesprávný zápis matice B."
        end
        if (n.index(/^[-]{0,1}[0-9]{1,}$/) == nil && n.index(/^[-]{0,1}[0-9]{1,}[\/]{1}[-]{0,1}[1-9]{1,}[0-9]{0,}$/) == nil)
          @message << "N musí být celé číslo různé od nuly, nebo zlomek."
        end
      end

    end
    
    if self.un == "mb"
      mat_a = Matice.new(ma).get_matrix
      n = self.n.to_s
      n.gsub!(/\s/, '')

      if(mat_a != false && (n.index(/^[-]{0,1}[0-9]{1,}$/) != nil || n.index(/^[-]{0,1}[0-9]{1,}[\/]{1}[-]{0,1}[1-9]{1,}[0-9]{0,}$/) != nil)) then
        self.n = n.to_i
        mat_b = mat_a * self.n
        #self.mb = mat_b.to_s.slice(7, mat_b.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, '][')
        result = true
      else
        if mat_a == false then
          @message << "Nesprávný zápis matice A."
        end
        if (n.index(/^[-]{0,1}[0-9]{1,}$/) == nil && n.index(/^[-]{0,1}[0-9]{1,}[\/]{1}[-]{0,1}[1-9]{1,}[0-9]{0,}$/) == nil)
          @message << "N musí být celé číslo různé od nuly, nebo zlomek."
        end
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
    end
    puts "Model M2"
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
