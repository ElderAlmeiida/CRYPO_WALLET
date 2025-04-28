class AddCoinGeckoIdToCoins < ActiveRecord::Migration[8.0]
  def change
    add_column :coins, :coin_gecko_id, :string
  end
end
