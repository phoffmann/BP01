module MainHelper
  def main_tree_menu
    @lv1 = Group.my_menu(0.to_s)
    @menu = "<ul id=\"treemenu1\" class=\"treeview\">\r\n"

    for i in @lv1 do
      @menu += "\t<li><a class=\"skupina\">" + i.name + "</a>\r\n\t\t<ul>\r\n"
      @ch = Group.my_menu(i.id.to_s)
      for c in @ch do
        #@menu += "\t\t\t<li><a href=\"/main/list_group/" + c.id.to_s + "\">" + c.name + "</a></li>\r\n"
        #@group = Group.find(c.id)
        @menu += "\t\t\t<li><a href=\"/main/list_group/" + c.id.to_s + "\">" + c.name + "</a>\r\n"
        #@group = Group.find(c.id)
        #if @group.exams.size > 0
        #  @menu += "\t\t\t\t<ul>\r\n"
        #  for e in @group.exams do
        #    @menu += "\t\t\t\t\t<li><a>" + e.desc + "</a></li>\r\n"
        #  end
        #  @menu += "\t\t\t\t</ul>\r\n"
        #end
        @menu += "\t\t\t</li>\r\n"
      end
      @menu += "\t\t</ul>\r\n\t</li>\r\n"
    end
    @menu += "\t</ul>\r\n"
    #return "Pomocnik...."
    return @menu
  end
end
