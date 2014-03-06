require 'test_helper'

class PullRequestControllerTest < ActionController::TestCase
  webhook_json = ActiveSupport::JSON.decode(File.read('test/fixtures/webhook.json'))

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get 'new' json endpoint" do
    get :new, webhook_json
    assert_response :success
  end
end
