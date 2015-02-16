require 'yaml/store'

class TaskManager
  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager_dev.sqlite3")
    end
  end

  def self.create(task)
    database.transaction do
      new_id = database[:tasks].to_a.count + 1
      database[:tasks] << { "id"=> new_id, "title"=> task[:title], "description" => task[:description]} 
    end
  end

  def self.raw_tasks
      database[:tasks]
      #dataset object
  end

  def self.all
    raw_tasks.map { |data| Task.new(data) }
  end

  def self.raw_task(id)
    raw_tasks.find { |task| task[:id] == id }
  end

  def self.find(id)
    # require 'pry';binding.pry
    Task.new(raw_task(id))

    # tasks = database['tasks']
    # Task.new({ :id=> 1, :title=> tasks[:title], :description=>'a description'})
    #find method returns a Task object based on the id#
    #id # gets passed in
    #if I have Task objects, I can call .title, .id, .description on them
  end

  def self.update(id, task)
    #task above is the task you arepassing in
      raw_tasks.where(:id => id).update(:title => task[:title], :description => task[:description])
  end

  def self.delete(id)
      database[:tasks].delete { |task| task[:id] == id }
  end

  def self.delete_all
    # go into database and resetting everything to 0
      database[:tasks].delete
  end

end