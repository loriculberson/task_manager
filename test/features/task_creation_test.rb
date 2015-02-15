require_relative '../test_helper'

class UserCreatesTaskTest < FeatureTest

  def test_user_creates_a_task

    visit '/' 
    click_link_or_button('New Task')
    assert_equal '/tasks/new', current_path
    
    fill_in 'task[title]', with: 'Eat ice cream'
    fill_in 'task[description]', with: 'omg yum'
    click_link_or_button('submit')

    assert_equal '/tasks',current_path
    within('#task-list') do 
      assert page.has_content?('Eat ice cream')    
    end
  end

end