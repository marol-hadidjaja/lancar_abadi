class SaleDetailsController < ApplicationController
  def get_data
    @sale = Sale.find(params[:sale_id])
    @product_units = UnitOfMeasure.where(:id => 0)
  end

  def get_product
    @products = Product.search_product(params[:keyword], params[:product_type], params[:merk], params[:size])
    .sort_product(params[:column], params[:direction])
    .paginate(:page => params[:page], :per_page => 500)
    # .order(:name, :product_type, :merk, :size)

    @keyword = params[:keyword] if params[:keyword].present?
    @product_type = params[:product_type] if params[:product_type].present?
    @merk = params[:merk] if params[:merk].present?
    @size = params[:size] if params[:size].present?
    @column = params[:column] if params[:column].present?
    @direction = params[:direction] if params[:direction].present?
  end

  def show_product
    get_data
    get_product
  end

  def search_product
    get_data
    get_product
  end

  def sort_product
    get_data
    get_product
  end

  def pick_product
    get_data
    @product = Product.find(params[:product_id])
    @product_unit_default = UnitOfMeasure.find_by_id(@product.try(:unit_of_measure_id).to_i)
    @product_units = @product.details.order(:id)
    @purchase_prices = @product.purchases.order(:id).reverse_order.limit(5)
    @sale_histories = SaleDetail.where(:product_id => @product.id).order(:updated_at).reverse_order.limit(5)

    store_cust_group = CustomerGroup.find_by_name("Bakul/Toko")
    case store_cust_group.selected_price.to_i
    when 1
      @store_cust_price = @product.sales_price.to_f * store_cust_group.formula.to_f
    when 2
      @store_cust_price = @product.purchases.last.try(:purchase_price).to_f * store_cust_group.formula.to_f
    else
      @store_cust_price = 0
    end

    workshop_cust_group = CustomerGroup.find_by_name("Bengkel/Montir")
    case workshop_cust_group.selected_price.to_i
    when 1
      @workshop_cust_price = @product.sales_price.to_f * workshop_cust_group.formula.to_f
    when 2
      @workshop_cust_price = @product.purchases.last.try(:purchase_price).to_f * workshop_cust_group.formula.to_f
    end

    if @sale.customer_group_id.to_i==store_cust_group.id
      @default_price = @store_cust_price.to_f
    elsif @sale.customer_group_id.to_i==workshop_cust_group.id
      @default_price = @workshop_cust_price.to_f
    else
      @default_price = @product.sales_price.to_f
    end

    if @default_price.to_f == 0
      @default_price = ""
    end
  end

  # GET /sale_details/new
  # GET /sale_details/new.json
  def new
    get_data
    @sale_detail = @sale.details.new
    @sale_detail.quantity = ""
    @sale_detail.price = ""
    @sale_detail.discount = ""
  end

  # GET /sale_details/1/edit
  def edit
    get_data
    @sale_detail = @sale.details.find(params[:id])
    if @sale_detail.price.to_f == 0
      @sale_detail.price = ""
    end
    if @sale_detail.discount.to_f == 0
      @sale_detail.discount = ""
    end

    @product = Product.find(@sale_detail.product_id)
    @product_unit_default = UnitOfMeasure.find_by_id(@product.try(:unit_of_measure_id).to_i)
    @product_units = @product.details.order(:id)
  end

  # POST /sale_details
  # POST /sale_details.json
  def create
    get_data
    @sale_detail = @sale.details.create(params[:sale_detail])
    @sale_detail.quantity = 1 if @sale_detail.quantity.to_i==0
    get_data
  end

  # PUT /sale_details/1
  # PUT /sale_details/1.json
  def update
    get_data
    @sale_detail = @sale.details.find(params[:id])
    @sale_detail.update_attributes(params[:sale_detail])
    get_data
  end

  # DELETE /sale_details/1
  # DELETE /sale_details/1.json
  def destroy
    get_data
    @sale_detail = @sale.details.find(params[:id])
    @sale_detail.destroy
    get_data
  end
end
