require 'pry'
require 'date'
require './db/setup'
require './lib/all'

class To_do_list
  def log_in
    print "Please enter your name > "
    username = gets.chomp
    @user = User.where(name: username).first_or_create!
    puts "Thank you for logging in, #{@user.name}."
  end

  def get_command
    puts "What would you like to do? Available commands: Add, Due, Done, List, List all, Next, Search"
    command = gets.chomp.downcase
    case command
      when "add"
        add_task
      when "due"
        add_due_date
      when "done"
        mark_done
      when "list"
        list_tasks_by_list_name
      when "list all"
        list_all_tasks
      when "next"
        random_task
      when "search"
        search_tasks
      else
        puts "You gave me #{command} -- I have no idea what to do with that."
    end
  end

  def add_task
    print "Please enter the task description > "
    task = gets.chomp
    print "Please enter a category name for the task > "
    list_name = gets.chomp
    @user.tasks.create! task: task, list_name: list_name
    #Gif.create! url: link, creator_id: user.id
  end

  def add_due_date
    puts "Please enter the task id > "
    id = gets.chomp
    puts "Please enter the due date > "
    date = Date.parse(gets.chomp)
    t = @user.tasks.find(id.to_i)
    t.due_date = date
    t.save
  end

  def mark_done
    puts "Please enter the task id > "
    id = gets.chomp
    t = @user.tasks.find(id.to_i)
    t.completed = true
    t.save
  end

  def list_tasks_by_list_name
    puts "Please enter the task list name > "
    list_name = gets.chomp
    list = @user.tasks.where(list_name: list_name)
    print_out list
  end

  def list_all_tasks
    list = @user.tasks.all
    print_out list
  end

  def search_tasks
    puts "What would you like to search for? > "
    search_term = gets.chomp
    list = @user.tasks.where("task LIKE ?", "%#{search_term}%")
    print_out list
  end

  def random_task
    t = @user.tasks.where("due_date IS NOT NULL").sample
    puts "Id: #{t.id}\t User Id: #{t.user_id}\t Task: #{t.task}\t Due: #{t.due_date}"
  end

  def all_tasks
    list = @user.task.all
    print_out list
  end

  def print_out list
    list.each do |t|
      puts "Id #{t.id}\t User Id: #{t.user_id}\t Task: #{t.task}\t Due: #{t.due_date}"
    end
  end
end

to_do_bot = To_do_list.new
to_do_bot.log_in
to_do_bot.get_command
