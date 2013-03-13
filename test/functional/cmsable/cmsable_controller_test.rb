require 'test_helper'

module Cmsable
  class CmsableControllerTest < ActionController::TestCase
    test "should get update" do
      get :update
      assert_response :success
    end
  
  end
end
