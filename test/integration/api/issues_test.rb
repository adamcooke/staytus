require 'test_helper'

class IssuesTest < ActionDispatch::IntegrationTest
  test "returns issues" do
    get "/api/v1/issues/all"

    assert_equal 2, json_response[:data].size
  end

  test "retuns one issue" do
    post_json "/api/v1/issues/info", { issue: issues(:one).id }

    assert_equal 'issue 1', json_response[:data][:title]
  end
end
