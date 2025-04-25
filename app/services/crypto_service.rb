class CryptoService
  BASE_URL = "https://api.coingecko.com/api/v3"

  def self.search(query)
    response = HTTP.get("#{BASE_URL}/search?query=#{query}")
    data = JSON.parse(response.body.to_s)
    coins = data["coins"]

    return nil if coins.empty?

    coins.map do |coin|
      {
        id: coin["id"],
        name: coin["name"],
        symbol: coin["symbol"],
        image: coin["large"]  # link da imagem
      }
    end
  rescue StandardError => e
    Rails.logger.error "Erro na busca de cripto: #{e.message}"
    nil
  end

  def self.details(id)
    response = HTTP.get("#{BASE_URL}/coins/#{id}")
    data = JSON.parse(response.body.to_s)

    {
      name: data["name"],
      symbol: data["symbol"],
      image: data["image"]["large"],
      price_usd: data["market_data"]["current_price"]["usd"],
      high_24h: data["market_data"]["high_24h"]["usd"],  # Maior preço nas últimas 24h
      low_24h: data["market_data"]["low_24h"]["usd"]    # Menor preço nas últimas 24h
    }
  rescue StandardError => e
    Rails.logger.error "Erro ao buscar detalhes da cripto: #{e.message}"
    nil
  end
end
