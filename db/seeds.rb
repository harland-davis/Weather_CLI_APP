User.destroy_all
City.destroy_all
FavoriteCity.destroy_all

blake = User.create(username: "brunyon", password: "password-time")
blake_clone = User.create(username: "brunyon", password: "new_password")

chicago = City.create(name: "Chicago")
chicago_clone = City.create(name: "Chicago")

fav_city_1 = FavoriteCity.create(user: blake, city: chicago)