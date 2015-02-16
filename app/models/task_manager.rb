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
    Task.new(raw_task(id))
    #find method returns a Task object based on the id#
    #id num gets passed in
    #if I have Task objects, I can call .title, .id, .description on them
  end

  def self.update(id, task)
    #task above is the task hash you are passing in
      raw_tasks.where(:id => id).update(:title => task[:title], :description => task[:description])
  end

  def self.delete(id)
      raw_tasks.where(:id => id).delete {|task| task[:id] == id}
  end

  def self.delete_all
    # go into database and resetting everything to 0
    #needed so that the tests clear out found data before running the next test
      database[:tasks].delete
  end

end