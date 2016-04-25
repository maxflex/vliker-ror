class GiftCodesController < ApplicationController
  before_action :set_gift_code, only: [:show, :edit, :update, :destroy]

  # GET /gift_codes
  # GET /gift_codes.json
  def index
    @gift_codes = GiftCode.all
  end

  # GET /gift_codes/1
  # GET /gift_codes/1.json
  def show
  end

  # GET /gift_codes/new
  def new
    @gift_code = GiftCode.new
  end

  # GET /gift_codes/1/edit
  def edit
  end

  # POST /gift_codes
  # POST /gift_codes.json
  def create
    @gift_code = GiftCode.new(gift_code_params)

    respond_to do |format|
      if @gift_code.save
        format.html { redirect_to @gift_code, notice: 'Gift code was successfully created.' }
        format.json { render :show, status: :created, location: @gift_code }
      else
        format.html { render :new }
        format.json { render json: @gift_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gift_codes/1
  # PATCH/PUT /gift_codes/1.json
  def update
    respond_to do |format|
      if @gift_code.update(gift_code_params)
        format.html { redirect_to @gift_code, notice: 'Gift code was successfully updated.' }
        format.json { render :show, status: :ok, location: @gift_code }
      else
        format.html { render :edit }
        format.json { render json: @gift_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gift_codes/1
  # DELETE /gift_codes/1.json
  def destroy
    @gift_code.destroy
    respond_to do |format|
      format.html { redirect_to gift_codes_url, notice: 'Gift code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check
    # gift_code = GiftCode.find_by(code: params[:code], good_id: params[:good_id], activated: false)
    gift_code = GiftCode.find_by(code: params[:code], activated: false)
    respond_to do |format|
      if gift_code.nil?
        format.json {render json: {text: 'Ошибка. Введен неверный или активированый код'}, status: :unprocessable_entity}
      else
        # gift_code.activated = true
        # gift_code.save
        format.json {render json: {text: 'Спасибо! Код для ' + gift_code.good.full_name + ' активирован!' }, status: :ok}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift_code
      @gift_code = GiftCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_code_params
      params.require(:gift_code).permit(:good_id, :code, :activated, :user_id)
    end
end
