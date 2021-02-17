class User < ActiveRecord::Base
    validates_uniqueness_of :username

    has_many :favorite_cities
    has_many :cities, through: :favorite_cities
end