module ApplicationHelper
  def date_br(data_us, time_us)
    formatted_date = data_us.strftime("%d/%m/%Y")      # Formata a data
    formatted_time = time_us.strftime("at %I:%M %p")   # Formata a hora

    "#{formatted_date} #{formatted_time}"  # Retorna as duas informações concatenadas
  end
  def nome_aplicacao
    "CRYPTO WALLET APP"
  end

  def header
  end
  def ambiente_rails
    if Rails.env.development?
      "Desenvolvimento"
    elsif RAils.env.production?
        "Produção"
    else
        "Teste"
    end
  end
end
