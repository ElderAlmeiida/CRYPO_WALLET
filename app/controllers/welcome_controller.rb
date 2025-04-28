class WelcomeController < ApplicationController
  def index
    @coin = Coin.new
    @coins = Coin.all

    @nome = "Elder"
  end
end
