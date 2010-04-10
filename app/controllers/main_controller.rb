class MainController < ApplicationController
  layout 'main'

  def index
    
  end

  def list_group
    @group = Group.find(params[:id])
    @parent_group = Group.find(@group.parent_id)
  end

  def show_exam
    @group = Group.find(params[:group_id])
    @parent_group = Group.find(@group.parent_id)
    @exam= Exam.find(params[:id])
    @mark_max = 0
    
    for task in @exam.tasks
      @mark_max += task.mark
    end

  end

  def exam_old
    @group = Group.find(params[:group_id])
    @parent_group = Group.find(@group.parent_id)
    @exam = Exam.find(params[:id])
    #@training = Training.new

    if session[:training]
      @training = session[:training]
    else
      @training = Training.new
      #@training = Array.new
    end

    if params[:task_id]
      @task_id = params[:task_id]
    else
      @task_id = nil
    end
    
    if params[:save]
      @save = true
    else
      @save = false
    end

    @mark_max = 0

    for task in @exam.tasks
      @mark_max += task.mark
    end

    puts " start ###########################################################################"
    if @save
      #puts "Ulozit do session"
      
      @task = Task.find(@task_id)

      if @task.resource_type == "M3"
        @m3 = M3.new(params[:m3])
        @un = @task.resource.un

        case @un
        when "ma"
          @un_data = @m3.ma
        when "mb"
          @un_data = @m3.mb
        when "mc"
          @un_data = @m3.mc
        end

        #puts "un_data:"+@un_data
      end

      @training.items << @task_activity
      #puts "training.items:"+@training.items.to_s
      #puts "session:"
      session[:training] = @training
      #puts session.to_s
      #puts " end ###########################################################################"
      @neco
      @debug = @neco
    end
    # konec if @save

  end

  def exam
    @group = Group.find(params[:group_id])
    @parent_group = Group.find(@group.parent_id)
    @exam = Exam.find(params[:id])
    @error_message = []
    @rate = false
    @task_id = nil
    @mark_reached = 0


    if params[:task_id]
      if params[:task_id] == "c"# vyhodnotit test
        @rate = true
      else
        @task_id = params[:task_id]
      end
    end

    if params[:r]# reset training in session
      session[:training] = Training.new
      @task_id = nil
    end

    if session[:training]
      @training = session[:training]
      #@training = Training.new
    else
      @training = Training.new
    end

    if params[:save]
      @save = true
    else
      @save = false
    end

    @mark_max = 0# pocet bodu za exam

    for task in @exam.tasks
      @mark_max += task.mark
    end

    if @save && @task_id

      @task = Task.find(@task_id)

      # Soucin dvou matice
      if @task.resource_type == "M3"
        @un = @task.resource.un# matice jenz ma student vypocitat, un_data matice, kterou student spocital
        @s_data = params[:m3][@un]
        @s_mat = Matice.new(@s_data)

        if @s_mat.get_matrix then
          @un_data = @s_mat.get_matrix_as_string
        else
          @error_message << "Neplatny format matice."
        end

        if @error_message.length == 0 then
          @task_activity = TaskActivityM3.new(@task.id, @task.resource_type, "saved", @un, @un_data)
        end
      end

      # Inverzni matice
      if @task.resource_type == "Inv1"
        #puts "--------- Inv1 -----------------"
        @un = @task.resource.un# matice jenz ma student vypocitat, un_data matice, kterou student spocital
        @s_data = params[:inv1][@un]
        @s_mat = Matice.new(@s_data)
        
        if @s_mat.get_matrix then
          @un_data = @s_mat.get_matrix_as_string
          #puts "--- Inv un_data ---"
          #puts @un_data
        else
          @error_message << "Neplatny format matice."
        end

        if @error_message.length == 0 then
          @task_activity = TaskActivityInv1.new(@task.id, @task.resource_type, "saved", @un, @un_data)
        else
          #@task_activity = TaskActivityInv1.new(@task.id, @task.resource_type, "saved", @un, @un_data)
        end
      end

      #@debug = @error_message

      # Nasobeni matice cislem
      if @task.resource_type == "M2"
        #@m2 = @task.resource
        @un = @task.resource.un# matice jenz ma student vypocitat, un_data matice, kterou student spocital
        @s_data = params[:m2][@un]
        @s_mat = Matice.new(@s_data)

        if @s_mat.get_matrix then
          @un_data = @s_mat.get_matrix_as_string
        else
          @error_message << "Neplatny format matice."
        end

        if @error_message.length == 0 then
          @task_activity = TaskActivityM2.new(@task.id, @task.resource_type, "saved", @un, @un_data)
        end
      end

      # Hodnost matice
      if @task.resource_type == "M1"
        @m1 = M1.new(params[:m1])
        @s_data = params[:m1]['n']
        #@un = @task.resource.un# matice jenz ma student vypocitat, un_data matice, kterou student spocital

        if @s_data.index(/^[0-9]{1,}$/) then
          @un_data = @s_data
          puts "M1 ok"
        else
          @error_message << "Cislo N musi byt kladne cele cislo."
        end

        if @error_message.length == 0 then
          @task_activity = TaskActivityM1.new(@task.id, @task.resource_type, "saved", @un_data)
        end
      end

      if @error_message.length == 0 then

        @sess_task_idx = @training.find_activity(@task_id.to_i)
        if @sess_task_idx
          puts "------------- sess03"
          @task_activity_sess = @training.items[@sess_task_idx]
        end

        if @training.find_activity(@task_activity.id)
          puts "uz existuje v training"
          @training.items[@sess_task_idx] = @task_activity
        else
          @training.add_activity(@task_activity)
          puts "nexistuje v training"
        end

      end#@error_message
      
      #@neco
      #@debug = @neco
    end# konec @save && @task_id
    
    if @task_id# nacteni ulozeneho tasku(aktivity ze session)
      puts "------------- sess01"
      @sess_task_idx = @training.find_activity(@task_id.to_i)
      if @sess_task_idx
        puts "--------------sess02"
        @task_activity_sess = @training.items[@sess_task_idx]
      end
    end

    # konec exam
    if @rate then
      @rate_data = []
      for task in @exam.tasks do
        task_idx = @training.find_activity(task.id)
        puts "task_id:"+task.id.to_s+" task_name:"+task.name
        if task_idx == nil then
          case task.resource_type
          when "M3"
            puts "M3 task: "+task.id.to_s+" " +task.name+ " not in session"
            activity = TaskActivityM3.new(task.id, task.resource_type, "saved", task.resource.un, nil)
          when "M2"
            puts "M2 task: "+task.id.to_s+" not in session"
            activity = TaskActivityM2.new(task.id, task.resource_type, "saved", task.resource.un, nil)
          when "M1"
            puts "M1 task: "+task.id.to_s+" not in session"
            activity = TaskActivityM1.new(task.id, task.resource_type, "saved", nil)
          when "Inv1"
            puts "Inv1 task: "+task.id.to_s+" not in session"
            activity = TaskActivityInv1.new(task.id, task.resource_type, "saved", task.resource.un, nil)
          end#case
          @training.add_activity(activity)
          #@rate_data << [task,nil]
        else
          activity = @training.items[task_idx]
          #puts task.resource.print_as_table("ma", "")
          #rate_data << [task,activity]
        end#if task_idx
        @rate_data << [task,activity.data]
      end
    end#@rate

    @buffer = []
    @buffer << params
    @buffer << session
    @debug = @buffer
    puts "debug task_id"
    puts @task_id
  end

end
