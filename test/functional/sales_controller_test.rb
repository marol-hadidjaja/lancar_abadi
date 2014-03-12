require 'test_helper'

class SalesControllerTest < ActionController::TestCase
  setup do
    @sale = sales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale" do
    assert_difference('Sale.count') do
      post :create, sale: { added_discount: @sale.added_discount, discount: @sale.discount, notes: @sale.notes, si_id: @sale.si_id, status: @sale.status, sub_amount: @sale.sub_amount, tax: @sale.tax, tax_amount: @sale.tax_amount, total_amount: @sale.total_amount, transaction_date: @sale.transaction_date }
    end

    assert_redirected_to sale_path(assigns(:sale))
  end

  test "should show sale" do
    get :show, id: @sale
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale
    assert_response :success
  end

  test "should update sale" do
    put :update, id: @sale, sale: { added_discount: @sale.added_discount, discount: @sale.discount, notes: @sale.notes, si_id: @sale.si_id, status: @sale.status, sub_amount: @sale.sub_amount, tax: @sale.tax, tax_amount: @sale.tax_amount, total_amount: @sale.total_amount, transaction_date: @sale.transaction_date }
    assert_redirected_to sale_path(assigns(:sale))
  end

  test "should destroy sale" do
    assert_difference('Sale.count', -1) do
      delete :destroy, id: @sale
    end

    assert_redirected_to sales_path
  end
end