# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# admin
# User.create(first_name: "Maria", last_name: "Stoica", phone_number: "+40724017240", description: "I write code by day and fiction by night.", password: "foobar13", password_confirmation: "foobar13")
# User.create(first_name: "Andrei", last_name: "Neagu", phone_number: "+40724017241", description: "le CEO c'est moi", password: "foobar13", password_confirmation: "foobar13")
# User.create(first_name: "Darth", last_name: "Vader", phone_number: "+40724017242", description: "Come to the Dark side. We've got cookies.", password: "foobar13", password_confirmation: "foobar13")
# User.create(first_name: "Chester", last_name: "Horace", phone_number: "+40724017243", description: "check mate", password: "foobar13", password_confirmation: "foobar13")
# User.create(first_name: "Wix", last_name: "Pix", phone_number: "+40724017244", description: "tix", password: "foobar13", password_confirmation: "foobar13")

# interests
# Interest.create(name: "Sports", category_id: nil)  # 1
# Interest.create(name: "Games", category_id: nil)   # 2
# Interest.create(name: "Leisure", category_id: nil) # 3
# Interest.create(name: "Science", category_id: nil) # 4
# Interest.create(name: "Arts", category_id: nil)    # 5

# Interest.create(name: "Hiking", category_id: 1)
# Interest.create(name: "Volleyball", category_id: 1)
# Interest.create(name: "Tennis", category_id: 1)

# Interest.create(name: "Catan", category_id: 2)
# Interest.create(name: "Go", category_id: 2)
# Interest.create(name: "Chess", category_id: 2)

# Interest.create(name: "Reading", category_id: 3)
# Interest.create(name: "Travelling", category_id: 3)

# Interest.create(name: "Mathematics", category_id: 4)
# Interest.create(name: "Prime Numbers", category_id: 4)
# Interest.create(name: "Physics", category_id: 4)
# Interest.create(name: "Technology", category_id: 4)

# Interest.create(name: "Poetry", category_id: 5)
# Interest.create(name: "Young Adult Fiction Writing", category_id: 5)
# Interest.create(name: "Landscape Pastel Painting", category_id: 5)
# Interest.create(name: "Animal Sketching", category_id: 5)

# user_interests
# UserInterest.create(user_id: 1, interest_id: 6)
# UserInterest.create(user_id: 1, interest_id: 10)
# UserInterest.create(user_id: 1, interest_id: 19)

# UserInterest.create(user_id: 2, interest_id: 6)
# UserInterest.create(user_id: 2, interest_id: 10)
# UserInterest.create(user_id: 2, interest_id: 11)

# UserInterest.create(user_id: 3, interest_id: 6)
# UserInterest.create(user_id: 3, interest_id: 12)
# UserInterest.create(user_id: 3, interest_id: 13)
# UserInterest.create(user_id: 3, interest_id: 14)

# UserInterest.create(user_id: 4, interest_id: 11)
# UserInterest.create(user_id: 4, interest_id: 17)
# UserInterest.create(user_id: 4, interest_id: 18)
# UserInterest.create(user_id: 4, interest_id: 19)
# UserInterest.create(user_id: 4, interest_id: 20)

# UserInterest.create(user_id: 5, interest_id: 6)
# UserInterest.create(user_id: 5, interest_id: 7)
# UserInterest.create(user_id: 5, interest_id: 8)

# activities
# Activity.create(name: "Jogging", user_id: 2, location: "Parcul Tineretului", time: "2015-03-20 06:50:37", nrofpeopleinvited: 2)
# Activity.create(name: "Kafka books discussions", user_id: 3, location: "BCU", time: "2015-03-21 06:50:37", nrofpeopleinvited: 3)
# Activity.create(name: "Play Go", user_id: 1, location: "Biblioteca Nationala", time: "2015-03-22 06:50:37", nrofpeopleinvited: 7)
# Activity.create(name: "Kite flying", user_id: 5, location: "Plaja H2O, statiunea Mamaia", time: "2015-03-23 06:50:37", nrofpeopleinvited: 4)
# Activity.create(name: "Tennis Championship Attendance", user_id: 4, location: "Wimbledon, London", time: "2015-03-24 06:50:37", nrofpeopleinvited: 5)

# # going to activity
# Goingtoactivity.create(user_id: 2,activity_id: 1)
# Goingtoactivity.create(user_id: 3,activity_id: 2)
# Goingtoactivity.create(user_id: 1,activity_id: 3)
# Goingtoactivity.create(user_id: 5,activity_id: 4)
# Goingtoactivity.create(user_id: 3,activity_id: 1)
# Goingtoactivity.create(user_id: 4,activity_id: 2)
# Goingtoactivity.create(user_id: 5,activity_id: 3)
