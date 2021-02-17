class CreateCitiesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name, unique: true
    end
  end
end
