class City < ActiveRecord::Base 
    validates_uniqueness_of :name

    has_many :favorite_cities
    has_many :users, through: :favorite_cities 
end