class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def handle_well_known
    head :not_found  # Retorna um status 404 para qualquer requisição para .well-known
  end
end
