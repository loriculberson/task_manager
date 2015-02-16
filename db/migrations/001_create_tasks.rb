require 'sequel'

test_database = Sequel.sqlite('db/task_manager_test.sqlite3')
dev_database = Sequel.sqlite('db/task_manager_dev.sqlite3')

[test_database, dev_database].each do |database|
  database.create_table :tasks do
    primary_id :id
    String     :title
    Text       :description
  end
end