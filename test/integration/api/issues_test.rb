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

  test "updates issue" do
    post_json "/api/v1/issues/update", {
      id: issues(:two).id, text: 'waved magic wand, shit fixed', state: 'resolved', status: 'operational'
    }
    assert_equal 'waved magic wand, shit fixed', json_response[:data][:text]
    assert_equal 'resolved', json_response[:data][:state]

    post_json "/api/v1/issues/info", { issue: issues(:two).id }
    assert_equal 1, json_response[:data][:updates].count

    update = json_response[:data][:updates].first
    assert_equal 'waved magic wand, shit fixed', update[:text]
    assert_equal 'resolved', update[:state]
    assert_equal 'operational', update[:service_status][:permalink]
  end
end
