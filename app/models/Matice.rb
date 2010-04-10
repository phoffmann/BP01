require "mathn"
require "matrix"

class Matice
  attr_accessor :m, :mt
  def initialize(m)
    @m = m
    @mt = false
    # Odstrani vsechny bile znaky
    @m.gsub!(/\s/, '')
    @mt = get_matrix
  end

  def get_matrix_as_string
    puts "--- Matice - get_matrix_as_string ---"
    return @mt.to_s.slice(7, @mt.to_s.length - 8).to_s.gsub(/\s/, '').gsub(/\][,]\[/, "]\r\n[")
  end

  def get_matrix
    mt = false
    f = nil
    result = false
    if check_chars then
      puts "check_chars: OK"
      if check_brackets then
        puts "check_brackets: OK"
        if check_rows then
          puts "check_rows: OK"
          a = @m.slice(1, @m.length - 2)
          a = a.split("][")
          0.upto(a.length - 1) do |i|
            b = a[i].split(",", -100)
            0.upto(b.length-1) do |j|
              if check_number(b[j]) then
                result = true
                if b[j] == nil || b[j] == "" then
                end
              else
                result = false
              end
              if !result then
                break
              end
            end# 0.upto(b.length - 1)
            if !result then
              break
            end
          end# 0.upto(a.length - 1)
        end
      end
    end
    
    if result then
      a = @m.split("][")
      b = "Matrix["
      0.upto(a.length - 2) do |i|
        b += a[i] + "],["
      end
      b += a[a.length - 1] + "]"
      puts "--- Matice - get_matrix ---"
      puts b
      mt = eval(b)
    end
    puts mt.to_s
    return mt
  end

  def print_as_table(style_class = "")
    if style != "" then
      t = "<table class\""+style_class+"\">\r\n"
    else
      t = "<table>\r\n"
    end

    if @mt then
      0.upto(@mt.row_size - 1) do |i|
        t += "\t<tr>\r\n"
        0.upto(@mt.column_size - 1) do |j|
          t += "\t\t<td>"+@mt.[](i,j).to_s+"</td>\r\n"
        end
        t += "\t</tr>\r\n"
      end
    end
    t += "</table>\r\n"
    return t
  end

  private

  def check_number(v)
    n = v.to_s
    result = false
    if n.index(/^[-]{0,1}[0-9]{1,}[\/]{1}[-]{0,1}[1-9]{1,}[0-9]{0,}$/) || n.index(/^[-]{0,1}[0-9]{1,}[.]{1}[0-9]{1,}$/) || n.index(/^[-]{0,1}[0-9]{1,}$/) then
      result = true
    end
    return result
  end

  # Pokud je nalezen nepovoleny znak vraci false jinak true
  def check_chars
    if @m.index(/[^-1234567890,.\/\[\]]/) != nil then
      return false
    else
      return true
    end
  end

  # Kontroluje format matice [][], pokud je ok tak vraci true jinak false
  def check_brackets
    ar = @m.split(//)
    f = 0
    result = false
    if ar[0] == "[" then
      0.upto(ar.length - 1) do |i|
        if f > 1 || f < 0 then
          break
        end
        if ar[i] == "[" then
          f += 1
        end
        if ar[i] == "]" then
          f -= 1
        end
        if (f == 0) & (ar[i] != "]") then
          f = 10
          break
        end
      end
      if f == 0 then
        result = true
      end
    end
    return result
  end

  def check_rows
    result = true
    a = @m.slice(1, @m.length - 2)
    a = a.split("][", -1)
    c = nil
    0.upto(a.length - 1) do |i|
      b = a[i].split(",")
      #puts "--- Matice - check_rows ---"
      #puts "--- radek " + i.to_s + " ---"
      #puts a[i]
      # Prvni radek, naplni c pocten elementu v poli
      if c == nil then
        c = b.length
      end
      # Kontrola zda li ostatni radky maji stejny pocet prvku jako prvni
      if c != b.length
        result = false
        break
      end
    end
    return result
  end

end
