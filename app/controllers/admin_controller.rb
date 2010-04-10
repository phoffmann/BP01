class AdminController < ApplicationController
  layout 'admin'
  
  def index
    
  end

  ########
  # Task #
  ########

  def list_tasks
    @tasks = Task.all
    @task_kategories = TaskKategory.as_assoc_ar
  end

  def new_task
    @task = Task.new
    @task.resource_type = params[:task_kategory]
    @task_kategories = TaskKategory.as_assoc_ar

    if @task.resource_type == "M3"
      @m3 = M3.new
    end

    if @task.resource_type == "Inv1"
      @inv1 = Inv1.new
    end

    if @task.resource_type == "M2"
      @m2 = M2.new
    end
    if @task.resource_type == "M2"
      @m2 = M2.new
    end
    
    if @task.resource_type == "M1"
      @m1 = M1.new
    end
  end

  def create_task
    @task = Task.new(params[:task])
    @check_task = true
    @task_kategories = TaskKategory.as_assoc_ar

    if @task.resource_type == "M3"
      @m3 = M3.new(params[:m3])
      #check_task_result = @m3.check
      @check_task = @m3.check
      @task.resource = @m3
    end

    if @task.resource_type == "Inv1"
      @inv1 = Inv1.new(params[:inv1])
      @check_task = @inv1.check
      @task.resource = @inv1
    end

    if @task.resource_type == "M2"
      @m2 = M2.new(params[:m2])
      @check_task = @m2.check
      @task.resource = @m2
    end

    if @task.resource_type == "M1"
      @m1 = M1.new(params[:m1])
      @check_task = @m1.check
      @task.resource = @m1
    end

    if @check_task then
      if @task.save then
        flash[:notice] = "Úloha " + @task.name + ", " + @task_kategories[@task.resource_type] + " byla úspěšně vytvořena."
        redirect_to :action => "show_task", :id => @task
      else
        render :action => "new_task"
      end
    else
      flash[:notice] = @task.resource.message
      render :action => "new_task"
    end


    #if @task.save then
    #  flash[:notice] = "Task " + @task.resource_type + " successfuly created."
    #  redirect_to :action => "show_task", :id => @task
    #else
    #  render :action => "new_task"
    #end
    
  end

  def edit_task
    @task = Task.find(params[:id])
    @task_kategories = TaskKategory.as_assoc_ar
    
    if @task.resource_type == "M3"
      @m3 = @task.resource
    end

    if @task.resource_type == "Inv1"
      @inv1 = @task.resource
    end

    if @task.resource_type == "M2"
      @m2 = @task.resource
    end

    if @task.resource_type == "M1"
      @m1 = @task.resource
    end
  end

  def update_task
    @result = true
    @check_task = true
    @task = Task.find(params[:id])
    @notice = ""
    @error_message = []
    @task_kategories = TaskKategory.as_assoc_ar
  
    if @task.resource_type == "M3"
      @m3 = @task.resource
      @m3_new = M3.new(params[:m3])
      @check_task = @m3_new.check
      if @check_task then
        puts "check_task: ok"
        puts "params before"
        puts params[:m3]
        params[:m3]['un'] = @m3_new.un
        params[:m3]['ma'] = @m3_new.ma
        params[:m3]['mb'] = @m3_new.mb
        params[:m3]['mc'] = @m3_new.mc
        puts "params after"
        puts params[:m3]
      else
        puts "check_task: failed"
        @error_message = @m3_new.message.clone
      end
    end
    
    if @task.resource_type == "Inv1"
      @inv1 = @task.resource
      @inv1_new = Inv1.new(params[:inv1])
      @check_task = @inv1_new.check
      if @check_task then
        params[:inv1]['un'] = @inv1_new.un
        params[:inv1]['ma'] = @inv1_new.ma
        params[:inv1]['mb'] = @inv1_new.mb
      else
        puts "check_task: failed"
        @error_message = @inv1_new.message.clone
      end
    end

    if @task.resource_type == "M2"
      @m2 = @task.resource
      @m2_new = M2.new(params[:m2])
      @check_task = @m2_new.check
      if @check_task then
        params[:m2]['un'] = @m2_new.un
        params[:m2]['n'] = @m2_new.n
        params[:m2]['ma'] = @m2_new.ma
        params[:m2]['mb'] = @m2_new.mb
      else
        puts "check_task: failed"
        @error_message = @m2_new.message.clone
      end
    end

    if @task.resource_type == "M1"
      @m1 = @task.resource
      @m1_new = M1.new(params[:m1])
      @check_task = @m1_new.check
      if @check_task then
        params[:m1]['n'] = @m1_new.n
        params[:m1]['ma'] = @m1_new.ma
      else
        puts "check_task: failed"
        @error_message = @m1_new.message.clone
      end
    end

    if @task.update_attributes(params[:task])
      @notice = "Úloha" + @task.name + " byla upravena."

      if @check_task then
        
        if @task.resource_type == "M3"
          if @m3.update_attributes(params[:m3])
            #@notice += "<br>Task M3 successfuly updated."
            @error_message << "Task M3 successfuly updated."
          else
            @result = false
          end
        end

        if @task.resource_type == "Inv1"
          if @inv1.update_attributes(params[:inv1])
            #@notice += "<br>Task Inv1 successfuly updated."
            @error_message << "Task Inv1 successfuly updated."
          else
            @result = false
          end
        end

        if @task.resource_type == "M2"
          if @m2.update_attributes(params[:m2])
            #@notice += "<br>Task M2 successfuly updated."
            @error_message << "Task M2 successfuly updated."
          else
            @result = false
          end
        end

        if @task.resource_type == "M1"
          if @m1.update_attributes(params[:m1])
            #@notice += "<br>Task M1 successfuly updated."
            @error_message << "Task M1 successfuly updated."
          else
            @result = false
          end
        end
      else
        @result = false
      end
    else
      @result = false
    end

    if @result
      redirect_to :action => "show_task", :id => @task
      flash[:notice] = @notice
    else
      flash[:notice] = @error_message
      render :action => "edit_task"
    end
  end

  def show_task
    @task = Task.find(params[:id])
    @task_kategories = TaskKategory.as_assoc_ar
    
    if @task.resource_type == "M3"
      @m3 = @task.resource
    end

    if @task.resource_type == "Inv1"
      @inv1 = @task.resource
      puts "Task type INV1"
      puts @inv1
    end

    if @task.resource_type == "M2"
      @m2 = @task.resource
      puts "Task type M2"
      puts @m2
    end
    
    if @task.resource_type == "M1"
      @m1 = @task.resource
      puts "Task type M1"
      puts @m1
    end

  end

  def delete_task
    @task = Task.find(params[:id])
    if @task.resource_type == "M3"
      @m3 = M3.find(@task.resource_id).destroy
    end

    if @task.resource_type == "Inv1"
      @inv1 = Inv1.find(@task.resource_id).destroy
    end

    if @task.resource_type == "M2"
      @m2 = M2.find(@task.resource_id).destroy
    end

    if @task.resource_type == "M1"
      @m1 = M1.find(@task.resource_id).destroy
    end

    @task.destroy
    flash[:notice] = "Úloha: " + @task.name + " byla odstraněna."
    redirect_to :action => "list_tasks"
  end

  ########
  # Exam #
  ########

  def list_exams
    @exams = Exam.all
  end

  def new_exam
    @exam = Exam.new
  end

  def create_exam
    @exam = Exam.new(params[:exam])
    #@exam = Exam.new

    if @exam.save
      flash[:notice] = "Test" + @exam.name + " byl úspěšně vytvořen."
      redirect_to :action => "list_exams"
    else
      redirect_to :action => "new_exam"
    end
  end

  #def edit_exam
  #  @exam = Exam.find(params[:id])
  #  @task_kategories = TaskKategory.find(:all)
  #end

  def update_exam
    @exam = Exam.find(params[:id])
    if @exam.update_attributes(params[:exam])
      flash[:notice] = "Test byl úspěšně upraven."
      redirect_to :action => "show_exam", :id => @exam
    else
      render :action => "show_exam"
    end
  end

  def show_exam
    @exam = Exam.find(params[:id])
    @tasks = @exam.tasks
    @task_kategories = TaskKategory.as_assoc_ar

    @mark_max = 0# pocet bodu za exam

    for task in @exam.tasks
      @mark_max += task.mark
    end
  end

  def delete_exam
    @exam = Exam.find(params[:id]).destroy
    flash[:notice] = "Test: " + @exam.name + " byl odstraněn."
    redirect_to :action => "list_exams"
  end

  def choose_task
    @exam = Exam.find(params[:id])
    @task_kategories = TaskKategory.as_assoc_ar
    @tids = []

    for task in @exam.tasks do
      @tids << task.id
    end

    @mark_max = 0# pocet bodu za exam

    for task in @exam.tasks
      @mark_max += task.mark
    end

    @task_kategory = params[:task_kategory]
    #@task_kategories = TaskKategory.find(:all)
    
    if @task_kategory == "M3"
      @tasks = Task.find(:all, :conditions => "resource_type='M3'")
      @debug = @tasks
    end

    if @task_kategory == "Inv1"
      @tasks = Task.find(:all, :conditions => "resource_type='Inv1'")
      @debug = @tasks
    end

    if @task_kategory == "M2"
      @tasks = Task.find(:all, :conditions => "resource_type='M2'")
      @debug = @tasks
    end

    if @task_kategory == "M1"
      @tasks = Task.find(:all, :conditions => "resource_type='M1'")
      @debug = @tasks
    end
  end

  def add_task_to_exam
    @m3
    @task = Task.find(params[:task_id])
    @exam = Exam.find(params[:id])
    @exam.tasks << @task
    
    if @exam.save
      redirect_to :action => "show_exam", :id => @exam.id
    else
      render :action => "edit_exam", :id => @exam.id
    end
    #@exam.tasks.add
  end

  def remove_task_from_exam
    @task = Task.find(params[:task_id])
    @exam = Exam.find(params[:id])
    @exam.tasks.delete(@task)
    
    redirect_to :action => "show_exam", :id => @exam.id
  end

  #############
  # TaskType #
  #############

  def list_task_group
    @task_types = TaskType.find(:all)
  end

  #########
  # Group #
  #########

  def list_groups
    #@groups = Group.find(:all)
  end

  def new_group
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:level => [0,1]})
  end
  
  def create_group
    @group = Group.new(params[:group])

    if @group.parent_id == 0
      @group.level = 1
      @group_parent = Group.new
      @group_parent.id = 0
      @group_parent.level = 0
      #puts "root"
    else
      @group_parent = Group.find(@group.parent_id)
    end

    if @group_parent.level == 0
      @group.level = 1
    elsif @group_parent.level == 1
      @group.level = 2
    end

    if @group.save
      flash[:notice] = "Skupina " + @group.name + " byla úspěšně vytvořena."
      redirect_to :action => "list_groups"
    else
      render :action => "new_group"
    end
  end

  def delete_group
    @group = Group.find(params[:id]).destroy
    flash[:notice] = "Skupina " + @group.name + "byla odstraněna."
    redirect_to :action => "list_groups"
  end

  def update_group
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
      flash[:notice] = "Skupina " + @group.name + " byla upravena."
      redirect_to :action => "show_group", :id => @group
    else
      render :action => "show_group"
    end
  end

  def add_exam_to_group
    @group = Group.find(params[:id])
    @exam = Exam.find(params[:exam_id])
    @group.exams << @exam
    
    if @group.save
      flash[:notice] = "Test " + @exam.name + " byl přidán do skupiny " + @group.name + "."
      redirect_to :action => "show_group", :id => @group.id
    else
      render :action => "edit_group", :id => @group.id
    end
  end

  def show_group
    @group = Group.find(params[:id])
    #@exams_in_group = @group.exams

    #@group = Group.find(params[:id])
    @exams = Exam.find(:all)

    @exids = []
    for exam in @group.exams do
      @exids << exam.id
    end
  end

  def remove_exam_from_group
    @exam = Exam.find(params[:exam_id])
    @group = Group.find(params[:id])
    @group.exams.delete(@exam)

    redirect_to :action => "show_group", :id => @group.id
  end

end
