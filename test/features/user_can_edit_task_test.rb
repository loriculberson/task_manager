require_relative '../test_helper'

class UserEditsTaskTest < FeatureTest

  def test_user_edits_a_task
    TaskManager.create({ :title => "original title", 
                    :description => "original description"})

    visit '/tasks/1/edit'

    #user inputs new content    
    fill_in 'task[title]', with: 'new title'
    fill_in 'task[description]', with: 'new description'
    click_link_or_button('submit')

    assert_equal '/tasks/1', current_path

    within('#title') do
      assert page.has_content?('new title')
    end

    within('#description') do 
      assert page.has_content?('new description')
    end  
  end

  end