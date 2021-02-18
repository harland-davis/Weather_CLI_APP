User.destroy_all
City.destroy_all
FavoriteCity.destroy_all

blake = User.create(username: "brunyon", password: "123")
blake_clone = User.create(username: "brunyon", password: "new_password")
kyle = User.create(username: "kyle", password: "123")

chicago = City.create(name: "Chicago")
chicago_clone = City.create(name: "Chicago")
corvallis = City.create(name: "Corvallis")
columbus = City.create(name: "Columbus")
las_vegas = City.create(name: "Las Vegas")

fav_city_1 = FavoriteCity.create(user: blake, city: chicago)
fav_city_2 = FavoriteCity.create(user: kyle, city: corvallis)
