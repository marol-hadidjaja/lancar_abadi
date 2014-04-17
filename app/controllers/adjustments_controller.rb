class AdjustmentsController < ApplicationController
  # GET /adjustments
  # GET /adjustments.json
  def index
    @adjustments = Adjustment
    .where("EXTRACT(MONTH FROM transaction_date)=EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM transaction_date)=EXTRACT(YEAR FROM CURRENT_DATE)")
    .order(:created_at).reverse_order
    .pagination(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adjustments }
    end
  end

  # GET /adjustments/1
  # GET /adjustments/1.json
  def show
    @adjustment = Adjustment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adjustment }
    end
  end

  # GET /adjustments/new
  # GET /adjustments/new.json
  def new
    @adjustment = Adjustment.new

    respond_to do |format|
      # format.html # new.html.erb
      format.js
      format.json { render json: @adjustment }
    end
  end

  # GET /adjustments/1/edit
  def edit
    @adjustment = Adjustment.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  # POST /adjustments
  # POST /adjustments.json
  def create
    @adjustment = Adjustment.new(params[:adjustment])

    respond_to do |format|
      if @adjustment.save
        format.html { redirect_to @adjustment, notice: 'Adjustment was successfully created.' }
        format.json { render json: @adjustment, status: :created, location: @adjustment }
      else
        format.html { render action: "new" }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adjustments/1
  # PUT /adjustments/1.json
  def update
    @adjustment = Adjustment.find(params[:id])

    respond_to do |format|
      if @adjustment.update_attributes(params[:adjustment])
        format.html { redirect_to @adjustment, notice: 'Adjustment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adjustments/1
  # DELETE /adjustments/1.json
  def destroy
    @adjustment = Adjustment.find(params[:id])
    @adjustment.destroy

    respond_to do |format|
      format.html { redirect_to adjustments_url }
      format.json { head :no_content }
    end
  end
end
