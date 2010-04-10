class Training
  attr_accessor :items
  
  @items

  def initialize
    @items = []
  end

  def add_activity(activity)
    @items << activity
  end

  def find_activity(id)
    @result = nil
    if @items.size > 0
      i = 0
      for item in @items do
        if item.id == id
          @result = i
        end
        i += 1
      end
    end
    
    return @result
    
  end

  def get_activity(id)
    @result = nil
    if @items.size > 0
      i = 0
      for item in @items do
        if item.id == id
          @result = @items[i]
        end
        i += 1
      end
    end

    return @result

  end

end

class TaskActivity
  attr_accessor :id, :type, :status
  def initialize(id, type, status)
    @id = id
    @type = type
    @status = status
  end
end

class TaskActivityM3 < TaskActivity
  attr_accessor :un, :data
  def initialize(id, type, status, un, data)
    super(id, type, status)
    @un = un
    @data = data
  end
end

class TaskActivityInv1 < TaskActivity
  attr_accessor :un, :data
  def initialize(id, type, status, un, data)
    super(id, type, status)
    @un = un
    @data = data
    puts "--- TaskActivityInv1 ---"
  end
end

class TaskActivityM2 < TaskActivity
  attr_accessor :un, :data
  def initialize(id, type, status, un, data)
    super(id, type, status)
    @un = un
    @data = data
  end
end

class TaskActivityM1 < TaskActivity
  attr_accessor :data
  def initialize(id, type, status, data)
    super(id, type, status)
    @data = data
  end
end

class MaticeComparator
  attr_accessor :ms, :mx, :ok
  def initialize(ms,mx)
    @ms = ms
    @mx = mx
    @ok = true
  end

  def print_compared(class_style_table = "",class_style_td_err = "")
    if class_style_table != "" then
      t = "<table class=\"" + class_style_table + "\">\r\n"
    else
      t = "<table>\r\n"
    end

    title = ""
    mat_s = Matice.new(@ms).mt
    mat_x = Matice.new(@mx).mt

    if mat_s && mat_x then
      if mat_s.row_size > mat_x.row_size then
        r = mat_s.row_size
      else
        r = mat_x.row_size
      end

      if mat_s.column_size > mat_x.column_size then
        c = mat_s.column_size
      else
        c = mat_x.column_size
      end

      ms_a = mat_s.to_a
      mx_a = mat_x.to_a

      0.upto(r - 1) do |i|
        row = "\t<tr>\r\n"
        0.upto(c - 1) do |j|
          begin
            x = mx_a[i][j]
          rescue
            x = "?"
          end

          begin
            s = ms_a[i][j]
          rescue
            s = "?"
          end

          if x.to_s == ""
            x = "?"
          end

          if s.to_s == ""
            s = "?"
          end

          #puts "x: " + x.to_s
          #puts "s: " + s.to_s

          if x.to_s != "?" then
            title = " title=\"" + x.to_s + "\""
          else
            title = " title=\"_\""
          end

          if(x == s) then
            row += "\t\t<td>" + s.to_s + "</td>\r\n"
          else
            @ok = false
            if class_style_td_err != ""
              row += "\t\t<td class=\""+class_style_td_err+"\""+ title +">" + s.to_s + "</td>\r\n"
            else
              row += "\t\t<td>?</td>\r\n"
            end
          end
          title = ""
        end
        row += "\t</tr>\r\n"
        t += row
        #puts row
      end
    end
    t += "</table>\r\n"
    return t
  end
end
