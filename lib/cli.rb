require "pry"

class CLI
  attr_accessor :user, :task, :agenda

  def welcome
    puts ""
    puts "
    ╔╦╦╦═╦╗╔═╦═╦══╦═╗
    ║║║║╩╣╚╣═╣║║║║║╩╣
    ╚══╩═╩═╩═╩═╩╩╩╩═╝
    "
    puts "****************************".yellow
    puts "WELCOME TO YOUR LIST APP!".light_blue
    puts "****************************".yellow
  end

  ###########################################################################################

  def sign_in
    puts ""
    puts "*** Please fill in a username ***".yellow
    username_input = gets.chomp
    @user = User.find_or_create_by(name: username_input)
  end

  #############################################################################################

  def view_list
    puts ""
    puts "*** This is your list: ***".light_blue
    puts ""
    @user.tasks.each do |task_instance|
      puts "- #{task_instance.name.capitalize}:".blue

      #   binding.pry
      if task_instance.complete
        checkmark = "\u2713"
        puts "Completed " + checkmark.encode("utf-8")
      else
        puts "Not done"
      end
      puts "--------------------".green
    end
  end

  ############################################################################################

  def menu
    puts "\nMenu:".blue
    prompt = TTY::Prompt.new
    option = prompt.select("What would you like to do?".yellow) do |menu_items|
      puts ""
      # puts "1. View list".red
      # puts "2. Update list".red
      # puts "3. Add to list".red
      # puts "4. Delete".red
      menu_items.choice name: "View list".red, value: 1
      menu_items.choice name: "Update list".red, value: 2
      menu_items.choice name: "Add to list".red, value: 3
      menu_items.choice name: "Delete".red, value: 4
      menu_items.choice name: "Show me my completed list".red, value: 5
      menu_items.choice name: "Show me my incompleted list".red, value: 6
      # option = gets.chomp
    end
    puts ""

    if option == 1
      view_list
    elsif option == 2
      update_list
    elsif option == 3
      add
    elsif option == 4
      delete_task
      # puts "Please choose an option"
    elsif option == 5
      completed_list
    elsif option == 6
      incompleted_list
    end
  end

  #########################################################################################

  def add
    # binding.pry
    puts ""
    puts "*** Please add to your list ***".light_blue
    add_something = gets.chomp
    completed = gets.chomp
    task = Task.create(name: add_something, complete: completed)
    puts task.name
    puts ""
    puts "You added a task to your list!".yellow

    #@user = 0 agendas

    agenda = Agenda.create(user_id: @user.id, task_id: task.id)
    # @user = User.find(@user.id)

    view_list
    puts ""
    puts "*** Would you like to go back to Menu? ***".light_blue
    go_back = gets.chomp
    if go_back == "yes"
      menu
      puts ""
    else
      puts ""
      puts "Thank you for visiting your list app".yellow
    end
  end

  ##########################################################################################

  def update_list
    puts ""
    puts "*** Do you want to update this list? ***".light_blue
    puts ""
    response = gets.chomp
    puts ""
    if response == "no"
      puts "Thank you!".blue
    else
      puts "*** Please choose the task you want to update ***".yellow
      puts ""
      view_list

      chosen_task = gets.chomp
      task_to_update = @user.tasks.where(name: chosen_task)[0]

      change_task(task_to_update)
    end
    puts ""
  end

  ##########################################################################################

  def change_task(task_to_update)
    puts ""
    puts "*** Do you want to rename the task or complete it? ***".light_blue
    response = gets.chomp
    if response == "rename".red
      puts "*** What would you like to rename it? ***".light_blue
      rename = gets.chomp
      task_to_update.update(name: rename)
    elsif response == "complete"
      puts ""
      puts "*** Are you sure the task is done? ***".light_blue
      response2 = gets.chomp
      if response2 == "yes"
        puts ""
        task_to_update.update(complete: true)
        puts ""
      elsif response2 == "no"
        puts ""
        task_to_update.update(complete: false)
        binding.pry
      end

      puts "Thank you for updating!".yellow
    end

    # Task.find_by(user_id: user.id).update(name: chosen_task)
  end

  #########################################################################################

  def delete_task
    puts ""
    view_list
    puts ""
    puts "*** Please choose the task you want to delete ***".light_blue
    puts ""
    delete_this = gets.chomp
    puts ""
    puts "*** Are you sure you want to delete this task? ***".light_blue
    task_to_delete = gets.chomp
    puts ""
    if task_to_delete == "yes"
      # binding.pry
      task_to_delete_id = Task.find_by(name: delete_this).id
      # binding.pry
      #I need to find the task I want to delete first and
      # I need to delete it throug my Agenda bc I am the user, so I just want to delete my task, not someone else task,
      # that is why I need the task ID.
      # binding.pry
      Agenda.find_by(user_id: @user.id, task_id: task_to_delete_id).destroy

      puts "Task deleted".yellow
    else
      menu
    end
    # binding.pry
    @user.reload
    view_list
  end

  def completed_list
    puts ""
    completed_tasks = @user.tasks.select do |task|
      task.complete == true
    end
    completed_tasks.each do |task|
      puts "- #{task.name}:".blue
      checkmark = "\u2713"
    end
    if completed_tasks == true
      puts "Completed" + checkmark.encode("utf-8")
      puts "----------------".green
    else
      puts "You don't have completed tasks".light_blue
      puts ""
    end
  end

  def incompleted_list
    puts ""
    incompleted_tasks = @user.tasks.select do |task|
      task.complete == false
    end
    incompleted_tasks.each do |task|
      # puts task.name.blue
      puts "- #{task.name.capitalize}:".blue
    end
    if incompleted_tasks == false
      puts "Not done"
      puts "----------------".green
      puts ""
    else
      puts "You don't have incompleted tasks".light_blue
      puts ""
    end
  end
end
