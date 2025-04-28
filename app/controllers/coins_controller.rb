class CoinsController < ApplicationController
  before_action :set_coin, only: %i[show edit update destroy]

  def index
    @coins = Coin.all
    search if params[:query].present?
  end

# Supondo que este seja o seu método update_prices
def update_prices
  Coin.all.each do |coin|
    next if coin.coin_gecko_id.blank?

    begin
      coin_data = CryptoService.details(coin.coin_gecko_id)

      if coin_data.present?
        coin.update(
          price: coin_data[:price_usd],
          high_24h: coin_data[:high_24h],
          low_24h: coin_data[:low_24h]
        )
      end
    rescue => e
      Rails.logger.error "Erro ao atualizar moeda #{coin.acronym}: #{e.message}"
    end
  end

  updated_coins = Coin.select(:id, :price, :high_24h, :low_24h)

  render json: updated_coins
end







  def show
  end

  def new
    @coin = Coin.new
  end

  def edit
  end

  def create
    @coin = Coin.new(coin_params)

    respond_to do |format|
      if @coin.save
        format.html { redirect_to @coin, notice: "Coin criada com sucesso!" }
        format.json { render :show, status: :created, location: @coin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @coin.update(coin_params)
        format.html { redirect_to @coin, notice: "Coin atualizada com sucesso!" }
        format.json { render json: @coin, status: :ok } # Envia a moeda como resposta JSON
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coin.errors, status: :unprocessable_entity } # Retorna os erros como JSON
      end
    end
  end



  def destroy
    @coin.destroy

    respond_to do |format|
      format.html { redirect_to coins_path, notice: "Coin removida com sucesso!" }
      format.json { head :no_content }
    end
  end

  def import
    coin_data = CryptoService.details(params[:id])

    if coin_data.nil?
      redirect_to crypto_search_path, alert: "Cripto não encontrada para importação."
      return
    end

    coin = Coin.new(
      description: coin_data[:name],
      acronym: coin_data[:symbol]&.upcase,
      url_image: coin_data[:image],
      price: coin_data[:price_usd],
      high_24h: coin_data[:high_24h],
      low_24h: coin_data[:low_24h],
      coin_gecko_id: params[:id] # Salva o ID correto
    )

    if coin.save
      redirect_to coin_path(coin), notice: "Cripto importada com sucesso!"
    else
      redirect_to crypto_search_path, alert: "Erro ao salvar: #{coin.errors.full_messages.to_sentence}"
    end
  end

  private

  def set_coin
    @coin = Coin.find(params.require(:id))
  end

  def coin_params
    params.require(:coin).permit(:description, :acronym, :url_image, :price, :high_24h, :low_24h, :coin_gecko_id)
  end
end
