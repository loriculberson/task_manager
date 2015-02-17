class TaskManager
  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager_dev.sqlite3")
    end
  end

  def self.tasks_table
    database[:tasks]
    #dataset object
  end

  def self.create(task)
    tasks_table.insert(:title =>task[:title], :description => task[:description])
  end

  def self.all
    tasks_table.map { |data| Task.new(data) }
  end

  def self.raw_task(id)
    tasks_table.where(:id => id).first
    #when we call where on the dataset object, an array is returned
    #where returns an array of a hash. In order to return only the hash, we need to isolate it
    #by calling either .first
  end

  def self.find(id)
    Task.new(raw_task(id))
    #find method returns a Task object based on the id#
    #id num gets passed in
    #if I have Task objects, I can call .title, .id, .description on them
  end

  def self.update(id, task)
    #task above is the task hash you are passing in
      tasks_table.where(:id => id).update(:title => task[:title], :description => task[:description])
  end

  def self.delete(id)
      tasks_table.where(:id => id).delete 
  end

  def self.delete_all
    # go into database and resetting everything to 0
    #needed so that the tests clear out found data before running the next test
      database[:tasks].delete
  end

end