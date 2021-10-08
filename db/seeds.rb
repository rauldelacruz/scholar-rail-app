User.create(email: "admin@example.com", password: "123456", password_confirmation: "admin@example.com")
User.create(email: "student@example.com", password: "123456", password_confirmation: "student@example.com")
User.update_all confirmed_at: DateTime.now