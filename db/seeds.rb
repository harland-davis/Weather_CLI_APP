User.destroy_all

blake = User.create(username: "brunyon", password: "password-time")
blake_clone = User.create(username: "brunyon", password: "new_password")