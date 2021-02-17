class CreateFavoriteCitiesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_cities do |t|
      t.references :city
      t.references :user
    end
  end
end
