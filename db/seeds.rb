User.create(email: "admin@example.com", password: "123456", password_confirmation: "admin@example.com")
User.create(email: "student@example.com", password: "123456", password_confirmation: "student@example.com")
User.update_all confirmed_at: DateTime.now

Classroom.create(name: "Room1")
Classroom.create(name: "Room2")
Classroom.create(name: "Room3")

Service.create(name: "Algebra", duration: 45, client_price: 0)
Service.create(name: "Javascript", duration: 45, client_price: 0)
Service.create(name: "Italian", duration: 45, client_price: 0)