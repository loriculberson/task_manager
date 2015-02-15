require_relative '../test_helper'

class UserDeleteTaskTest < FeatureTest

  def test_user_can_delete_a_task
    TaskManager.create({ :title => "original title",
                  :description => "original description"})

    visit '/tasks'

    assert page.has_content?("original title")
    click_link_or_button('delete')
    assert_equal '/tasks', current_path
    refute page.has_content?("original title")
  end

end