require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get groups_search_url
    assert_response :success
  end

end
