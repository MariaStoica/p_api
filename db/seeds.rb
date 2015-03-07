# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# admin
User.create(first_name: "Admin", last_name: "Pengin", phone_number: "+40724017240", description: "admin", password: "foobar13", password_confirmation: "foobar13")

#interests
Interest.create(name: "Sports", category_id: nil)  # 1
Interest.create(name: "Games", category_id: nil)   # 2
Interest.create(name: "Leisure", category_id: nil) # 3
Interest.create(name: "Science", category_id: nil) # 4
Interest.create(name: "Arts", category_id: nil)    # 5

Interest.create(name: "Hiking", category_id: 1)
Interest.create(name: "Volleyball", category_id: 1)
Interest.create(name: "Tennis", category_id: 1)

Interest.create(name: "Catan", category_id: 2)
Interest.create(name: "Go", category_id: 2)
Interest.create(name: "Chess", category_id: 2)

Interest.create(name: "Reading", category_id: 3)
Interest.create(name: "Travelling", category_id: 3)

Interest.create(name: "Mathematics", category_id: 4)
Interest.create(name: "Prime Numbers", category_id: 4)
Interest.create(name: "Physics", category_id: 4)
Interest.create(name: "Technology", category_id: 4)

Interest.create(name: "Poetry", category_id: 5)
Interest.create(name: "Young Adult Fiction Writing", category_id: 5)
Interest.create(name: "Landscape Pastel Painting", category_id: 5)
Interest.create(name: "Animal Sketching", category_id: 5)