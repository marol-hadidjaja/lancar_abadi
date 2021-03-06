require 'test_helper'

class AdjustmentsControllerTest < ActionController::TestCase
  setup do
    @adjustment = adjustments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adjustments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adjustment" do
    assert_difference('Adjustment.count') do
      post :create, adjustment: { notes: @adjustment.notes, pa_id: @adjustment.pa_id, status: @adjustment.status, transaction_date: @adjustment.transaction_date, transaction_status: @adjustment.transaction_status }
    end

    assert_redirected_to adjustment_path(assigns(:adjustment))
  end

  test "should show adjustment" do
    get :show, id: @adjustment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adjustment
    assert_response :success
  end

  test "should update adjustment" do
    put :update, id: @adjustment, adjustment: { notes: @adjustment.notes, pa_id: @adjustment.pa_id, status: @adjustment.status, transaction_date: @adjustment.transaction_date, transaction_status: @adjustment.transaction_status }
    assert_redirected_to adjustment_path(assigns(:adjustment))
  end

  test "should destroy adjustment" do
    assert_difference('Adjustment.count', -1) do
      delete :destroy, id: @adjustment
    end

    assert_redirected_to adjustments_path
  end
end
