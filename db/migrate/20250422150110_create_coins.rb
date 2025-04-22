class CreateCoins < ActiveRecord::Migration[8.0]
  def change
    create_table :coins do |t|
      t.string :description
      t.string :acronym
      t.string :url_image
      t.float :price

      t.timestamps
    end
  end
end
