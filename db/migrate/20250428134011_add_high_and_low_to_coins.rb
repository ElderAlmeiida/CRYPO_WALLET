class AddHighAndLowToCoins < ActiveRecord::Migration[8.0]
  def change
    add_column :coins, :high_24h, :decimal
    add_column :coins, :low_24h, :decimal
  end
end
