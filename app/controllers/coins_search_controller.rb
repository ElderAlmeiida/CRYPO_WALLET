class CoinsSearchController < ApplicationController
  def search
    if params[:query].present?
      @results = CryptoService.search(params[:query])
    else
      @results = []
    end

    respond_to do |format|
      format.js   # Vai renderizar o arquivo search.js.erb
      format.html # Se necessário, você pode renderizar em HTML também
    end
  end
  def details
    coin_id = params[:id]  # Pega o ID da moeda da API
    @coin = CryptoService.details(coin_id)  # Chama o serviço que pega os detalhes da API

    # Caso o serviço não retorne nada, podemos tratar
    if @coin.nil?
      flash[:alert] = "Detalhes da moeda não encontrados."
      redirect_to root_path  # Ou qualquer outra ação desejada
    end
  end
end
