require_relative '../test_helper'

class FrontPageTest < FeatureTest

  def test_user_sees_greeting
    visit '/'
    within('#greeting') do
      assert page.has_content?("Welcome to the Task Manager")
    end
  end


  def test_user_sees_index_and_new_links
    visit '/'
    within('#nav') do
      assert page.has_link?("Task Index")
      assert page.has_link?("New Task")
    end
  end
end