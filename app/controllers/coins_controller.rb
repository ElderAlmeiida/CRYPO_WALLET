class CoinsController < ApplicationController
  before_action :set_coin, only: %i[ show edit update destroy ]

  # GET /coins or /coins.json
  def index
    @coins = Coin.all
    search if params[:query].present?
  end

  # GET /coins/1 or /coins/1.json
  def show
  end

  # GET /coins/new
  def new
    @coin = Coin.new
  end

  # GET /coins/1/edit
  def edit
  end

  # POST /coins or /coins.json
  def create
    @coin = Coin.new(coin_params)

    respond_to do |format|
      if @coin.save
        format.html { redirect_to @coin, notice: "Coin was successfully created." }
        format.json { render :show, status: :created, location: @coin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coins/1 or /coins/1.json
  def update
    respond_to do |format|
      if @coin.update(coin_params)
        format.html { redirect_to @coin, notice: "Coin was successfully updated." }
        format.json { render :show, status: :ok, location: @coin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coins/1 or /coins/1.json
  def destroy
    @coin.destroy

    respond_to do |format|
      format.html { redirect_to coins_path, status: :see_other, notice: "Coin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_coin
      @coin = Coin.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def coin_params
      params.require(:coin).permit(:description, :acronym, :url_image, :price)
    end
    def import
      coin_data = CryptoService.details(params[:id])

      if coin_data.nil?
        redirect_to crypto_search_path, alert: "Cripto não encontrada para importação."
        return
      end

      coin = Coin.new(
        description: coin_data[:name],
        acronym: coin_data[:symbol].upcase,
        url_image: coin_data[:image],
        price: coin_data[:price_usd]
      )

      if coin.save
        redirect_to coin_path(coin), notice: "Cripto importada com sucesso!"
      else
        redirect_to crypto_search_path, alert: "Erro ao salvar a cripto: #{coin.errors.full_messages.to_sentence}"
      end
    end
    def import
      coin_data = CryptoService.details(params[:id])

      if coin_data.nil?
        redirect_to crypto_search_path, alert: "Criptomoeda não encontrada para importação."
        return
      end

      coin = Coin.new(
        description: coin_data[:name],
        acronym: coin_data[:symbol].upcase,
        url_image: coin_data[:image],
        price: coin_data[:price_usd]
      )

      if coin.save
        redirect_to coin_path(coin), notice: "Criptomoeda importada com sucesso!"
      else
        redirect_to crypto_search_path, alert: "Erro ao salvar a criptomoeda: #{coin.errors.full_messages.to_sentence}"
      end
    end

    private

      # Use callbacks to share common setup or constraints between actions.
      def set_coin
        @coin = Coin.find(params.require(:id))
      end

      # Only allow a list of trusted parameters through.
      def coin_params
        params.require(:coin).permit(:description, :acronym, :url_image, :price)
      end
end
