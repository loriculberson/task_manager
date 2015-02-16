require_relative '../test_helper'

class TaskManagerTest < ModelTest
  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title", 
                         :description => "a description"})
    task = TaskManager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def test_raw_tasks_has_three_hashes   
    TaskManager.create({ :title => "go shopping", :description => "eggs, milk, butter"})
    TaskManager.create({ :title => "school", :description => "write tests"})
    TaskManager.create({ :title => "exercise", :description => "swim"})

    assert_equal 3, TaskManager.raw_tasks.count
    refute_equal 2, TaskManager.raw_tasks.count
  end

  def test_raw_tasks_title_is_go_shopping   
    TaskManager.create({ :title => "go shopping", :description => "eggs, milk, butter"})

    tasks = TaskManager.raw_tasks
    assert_equal "go shopping", tasks.first[:title] 
  end

  def test_it_can_count_all_tasks
    TaskManager.create({ :title => "go shopping", :description => "eggs, milk, butter"})
    TaskManager.create({ :title => "school", :description => "write tests"})
    TaskManager.create({ :title => "exercise", :description => "swim"})

    tasks = TaskManager.raw_tasks
    all_tasks = TaskManager.all
    assert_equal 3, all_tasks.count
  end

  def test_it_can_find_the_task_by_id
    
    TaskManager.create({ :title => "go shopping", :description => "eggs, milk, butter"})
    TaskManager.create({ :title => "school", :description => "write tests"})
    TaskManager.create({ :title => "exercise", :description => "swim"})

    task = TaskManager.find(3)
    assert_equal "exercise", task.title
    assert_equal "swim", task.description
    assert_equal 3, task.id
  end

  def test_it_can_update_a_task
  
    TaskManager.create({ :title => "go shopping", :description => "eggs, milk, butter"})
    TaskManager.update(1, { :title => "shop till you drop", :description => "candy, milk, hot dogs"})
    assert_equal "shop till you drop", TaskManager.find(1).title
    assert_equal "candy, milk, hot dogs", TaskManager.find(1).description

  end

  def test_it_can_delete_a_task
    
    TaskManager.create({ :title => "go shopping", :description => "eggs, milk, butter"})
    task_id = TaskManager.all.last.id

    TaskManager.delete(task_id)
    assert_equal [], TaskManager.all
  end
 
  def test_it_can_delete_all_tasks
    
    TaskManager.create({ :title => "go shopping", :description => "eggs, milk, butter"})
    TaskManager.create({ :title => "school", :description => "write tests"})

    TaskManager.delete_all
    assert_equal 0, TaskManager.all.count
    refute_equal 2, TaskManager.all.count
  end
end