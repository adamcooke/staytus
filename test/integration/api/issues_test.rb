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

  test "creates issues" do
    post_json "/api/v1/issues/create", {
      title: 'new issue',
      initial_update: 'houston!!!',
      services: [ 'api' ],
      state: 'investigating',
      status: 'partial-outage'
    }

    assert_equal 'success', json_response[:status]
    assert_equal 'new issue', json_response[:data][:title]
    assert_equal 'investigating', json_response[:data][:state]
  end
end
