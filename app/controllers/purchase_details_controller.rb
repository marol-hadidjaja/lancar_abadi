class PurchaseDetailsController < ApplicationController
  def get_data
    @purchase = Purchase.find(params[:purchase_id])
    @product_units = UnitOfMeasure.where(:id => 0)
  end

  def get_product
    # @products = Product
    # .search_product(params[:keyword])
    # .where(:supplier_id => @purchase.supplier_id)
    # .order(:name, :product_type, :merk)
    # .paginate(:page => params[:page], :per_page => 500)

    @products = Product.search_product(params[:keyword], params[:product_type], params[:merk], params[:size])
    .where(:supplier_id => @purchase.supplier_id)
    .sort_product(params[:column], params[:direction])
    .paginate(:page => params[:page], :per_page => 500)

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
    @product = Product.find(params[:product_id])
    @product_unit_default = UnitOfMeasure.find_by_id(@product.try(:unit_of_measure_id).to_i)
    @product_units = @product.details.order(:id)
    @last_purchase_price = @product.purchases.last.try(:purchase_price).to_f
  end

  # GET /purchase_details/new
  # GET /purchase_details/new.json
  def new
    get_data
    @purchase_detail = @purchase.details.new
    @purchase_detail.quantity = ""
    @purchase_detail.price = ""
    @purchase_detail.discount = ""
    @purchase_detail.quantity_print = ""
  end

  # GET /purchase_details/1/edit
  def edit
    get_data
    @purchase_detail = @purchase.details.find(params[:id])
    
    if @purchase_detail.quantity_print.to_f == 0
      @purchase_detail.quantity_print = ""
    end
    if @purchase_detail.price.to_f == 0
      @purchase_detail.price = ""
    end
    if @purchase_detail.discount.to_f == 0
      @purchase_detail.discount = ""
    end
  end

  # POST /purchase_details
  # POST /purchase_details.json
  def create
    get_data
    @purchase_detail = @purchase.details.create(params[:purchase_detail])
    get_data
  end

  # PUT /purchase_details/1
  # PUT /purchase_details/1.json
  def update
    get_data
    @purchase_detail = @purchase.details.find(params[:id])
    @purchase_detail.update_attributes(params[:purchase_detail])
    get_data
  end

  # DELETE /purchase_details/1
  # DELETE /purchase_details/1.json
  def destroy
    get_data
    @purchase_detail = @purchase.details.find(params[:id])
    @purchase_detail.destroy
    get_data
  end
end
