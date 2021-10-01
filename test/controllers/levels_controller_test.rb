require "test_helper"

class LevelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get levels_index_url
    assert_response :success
  end

  test "should get new" do
    get levels_new_url
    assert_response :success
  end
end
