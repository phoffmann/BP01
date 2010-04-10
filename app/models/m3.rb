class M3 < ActiveRecord::Base
  has_one :task, :as => :resource
  #belongs_to :task

  attr_reader :message
  
  def check
    puts "Kontrola zadani"
    puts self.un
    result = false
    @message = []

    if self.un == "mc"
      mat_a = Matice.new(ma).get_matrix
      mat_b = Matice.new(mb).get_matrix

      if (mat_a != false) && (mat_b != false) then
        if (mat_a.column_size == mat_b.row_size) then
          mat_c = mat_a * mat_b
          puts "Matice c:"
          puts mat_c
          #self.mc = mat_c.to_s.slice(7, mat_c.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
          puts mc
          result = true
        else
          @message << "Počet sloupců matice A se musí rovnat počtu řádků matice B."
        end
      else
        if mat_a == false then
          @message << "Nesprávný zápis matice A."
        end
        if mat_b == false then
          @message << "Nesprávný zápis matice B."
        end
      end
    end

    if self.un == "ma"
      mat_b = Matice.new(mb).get_matrix
      mat_c = Matice.new(mc).get_matrix

      if (mat_b != false) && (mat_c != false) then
        if (mat_b.square? && mat_c.square?) then
          if (mat_b.regular? && mat_c.regular?) then
            if (mat_b.row_size == mat_c.row_size) then
              mat_a = mat_c * mat_b.inverse
              puts "Matice a:"
              puts mat_a
              #self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
              puts ma
              result = true
            else
              @message << "Matice B a C musí být stejných rozměrů."
            end
          else
            if mat_b.regular? == false then
              @message << "Matice B musí být regulární."
            end
            if mat_c.regular? == false then
              @message << "Matice C musí být regulární."
            end
          end
        else
          if mat_b.square? == false then
            @message << "Matice B musí být čtvercová."
          end
          if mat_c.square? == false then
            @message << "Matice C musí být čtvercová."
          end
        end
      else
        if mat_b == false then
          @message << "Nesprávný zápis matice B."
        end
        if mat_c == false then
          @message << "Nesprávný zápis matice C."
        end
      end
    end

    #end
    
    if self.un == "mb"
      mat_a = Matice.new(ma).get_matrix
      mat_c = Matice.new(mc).get_matrix

      if (mat_a != false) && (mat_c != false) then
        if (mat_a.square? && mat_c.square?) then
          if (mat_a.regular? && mat_c.regular?) then
            if (mat_a.row_size == mat_c.row_size) then
              mat_b = mat_a.inverse * mat_c
              puts "Matice b:"
              puts mat_b
              #self.mb = mat_b.to_s.slice(7, mat_b.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
              puts mb
              result = true
            else
              @message << "Matice A a C musí být stejných rozměrů."
            end
          else
            if mat_a.regular? == false then
              @message << "Matice A musí být regulární."
            end
            if mat_c.regular? == false then
              @message << "Matice C musí být regulární."
            end
          end
        else
          if mat_a.square? == false then
            @message << "Matice A musí být čtvercová."
          end
          if mat_c.square? == false then
            @message << "Matice C musí být čtvercová."
          end
        end
      else
        if mat_a == false then
          @message << "Nesprávný zápis matice A."
        end
        if mat_c == false then
          @message << "Nesprávný zápis matice C."
        end
      end

    end

    if result then
      if (mat_a.row_size > 1) then
        self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
      else
        self.ma = mat_a.to_s.slice(7, mat_a.to_s.length - 8)
      end
      if (mat_b.row_size > 1) then
        self.mb = mat_b.to_s.slice(7, mat_b.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
      else
        self.mb = mat_b.to_s.slice(7, mat_b.to_s.length - 8)
      end
      if (mat_c.row_size > 1) then
        self.mc = mat_c.to_s.slice(7, mat_c.to_s.length - 8).to_s.gsub!(/\s/, '').gsub!(/\][,]\[/, "]\r\n[")
      else
        self.mc = mat_c.to_s.slice(7, mat_c.to_s.length - 8)
      end
    else
      if self.un == "ma"
        self.mb.gsub!(/\]\[/, "]\r\n[")
        self.mc.gsub!(/\]\[/, "]\r\n[")
      end
      if self.un == "mb"
        self.ma.gsub!(/\]\[/, "]\r\n[")
        self.mc.gsub!(/\]\[/, "]\r\n[")
      end
      if self.un == "mc"
        self.ma.gsub!(/\]\[/, "]\r\n[")
        self.mb.gsub!(/\]\[/, "]\r\n[")
      end
    end
    puts "Model M3"
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
    if(m == "mc") then
      return self.mc.gsub(/\s/, '').gsub(/\]\[/, "]<br>[")
    end
  end

  def print_m(m)
    puts "###########################"
    if m == "ma"
      puts m
      puts self.ma
    end
    if m == "mb"
      puts m
      puts self.ma
    end
    if m == "mc"
      puts m
      puts self.ma
    end
    puts "###########################"
  end
  
  def print_as_table(m, style_class = "")
    if m == "ma" then
      mt = self.ma
    elsif m == "mb"
      mt = self.mb
    else
      mt = self.mc
    end

    puts mt

    mt.gsub!(/[,]/, "</td><td>").gsub!(/[\[]/, "<tr><td>").gsub!(/[\]]/, "</td></tr>")
    if style_class != "" then
      mt = "<table class=\""+style_class+"\">"+mt+"</table>"
    else
      mt = "<table>"+mt+"</table>"
    end

    return mt

  end

end
