# Pengin API (final - March 2015)

##Users:

###1. Sign up

When making the sign up request, the user is created in the data base and the request for the one time password sms is made. The user will receive a one time password on the inputed phone number. The user will input that password and the app will make a login request with that password and the user's phone number and country code. (see login).

**POST** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/users

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json

*Body:*

* country_code
* phone_number
* first_name
* last_name
* description
* avatar (file upload)

**Returns: json**

### Terminal example

```
$ curl -H 'Content-Type: multipart/form-data' -H 'Accept: application/json' -F "user[country_code]=+40" -F "user[phone_number]=724017240" -F "user[first_name]=Sulfus" -F "user[last_name]=Vader" -F "user[description]=Come to the dark side" -F "user[avatar]=@owl.jpg" http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/users
```

Answer:

```
{
	"success":true,
	"message":"User was successfully created.",
	"id":3
}
```

---


###2. Login

####Step 1 - request a sms password



####Step 2 - verify the sms password

You make the login request after the user has inputed the password in the sms. 

**POST** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/login

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json

*Body:*

* country_code
* phone_number
* password

**Returns: json**

### Terminal example

```
$ curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/login -d '{ "session" : {"country_code" : "+40", "phone_number" : "724017240", "password" : "SMAUG"}}'
```

Answer:

```
{
	"success":true,
	"message":"The user has been logged in",
	"acc_token":"8_SvVe2lNambLmwMJUJMlA",
	"id":1
}

or

{
	"success":false,
	"message":"Acc_token already exists. You can't use the same password to auth a second time. Logout and login again."
}

or

{
	"success":false,
	"message":"Invalid phone/password combination"
}
```

---


###3. Logout

**DELETE** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/logout

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token]'

**Returns: json**

### Terminal example

```
$ curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X DELETE http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/logout -H 'Authorization: Token token=4FHcyehbIlpALoUGBecuDA'
```

Answer:

```
{
	"success":true,
	"message":"The user has been logged out"
}
```

---


###4. Get profile info

**GET** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/users/[:id]

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token]'

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' GET 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/users/1' -H 'Authorization: Token token=4FHcyehbIlpALoUGBecuDA'
```

Answer:

```
{
	"id":1,
	"first_name":"Maria",
	"last_name":"Stoica",
	"phone_number":"+40724017240",
	"avatar":"/system/users/avatars/000/000/001/original/Pary_portrait.png?1425717738",
	"description":"I code in the morning and write in the evening.",
	"created_at":"2015-03-05T07:48:52.015Z",
	"updated_at":"2015-03-07T08:42:18.612Z"
}
```


---

###5. Edit profile info (mandatory) and their interests (optional)

**PATCH** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/users/[:id]

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token]'

*Body:*

At least one of user's attributes (mandatory)

* phone_number
* first_name
* last_name
* avatar (file upload)
* description
* password
* password_confirmation
* user_interest[] = [:desired_interest_id]
* user_interest[] = [:desired_interest_id]
* user_interest[] = [:desired_interest_id]
* ...

How many interest ids you want. It can be none. (optional)
The interest ids passed must belong to the interests the user wants. The new interests are added to the user's list of interests and the ones that are not passed will be deleted if they occured previously in the user's list.

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' -H 'Authorization: Token token=0fxLFtgI1oj8IYsFV6HB5w' -X PATCH 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/users/1' -F "user[first_name]=Mango" -F "user[last_name]=Fish" -F "user_interests[]=13" -F "user_interests[]=10" -F "user_interests[]=8"
```

Answer:

```
{
	"success":true, 
	"message":"User and user interests was successfully updated."
}
```


---


##Interests

###6. Get categories

**GET** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/interest_categories

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
Should we pass auth_token here, too for tracking?

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' GET 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/interest_categories'
```

Answer:

```
[
	{"id":1,"name":"Sports"},
	{"id":2,"name":"Games"},
	{"id":3,"name":"Leisure"},
	{"id":4,"name":"Science"},
	{"id":5,"name":"Arts"}
]
```


---


###7. Get interests in a category

**GET** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/interests_of_category?interest_category_id=[:category_id]

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
Should we pass auth_token here, too for tracking?

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' GET 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/interests_of_category?interest_category_id=4'
```

Answer:

```
[
	{"id":14,"name":"Mathematics","category_id":4},
	{"id":15,"name":"Prime Numbers","category_id":4},
	{"id":16,"name":"Physics","category_id":4},
	{"id":17,"name":"Technology","category_id":4}
]
```


---


###8. Get interests of current user

**GET** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/my_interests

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token]'

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' GET 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/my_interests' -H 'Authorization: Token token=0fxLFtgI1oj8IYsFV6HB5w'
```

Answer:

```
[
	{"id":8,"name":"Tennis","category_id":1},
	{"id":13,"name":"Travelling","category_id":3},
	{"id":17,"name":"Technology","category_id":4}
]
```


---


###9. Edit user interests only

*separate link just for interests in case no user data is altered (so it doesn't depend on user edit)*

**POST** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/edit_my_interests

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token]'

*Body:*

* user_interest[] = [:desired_interest_id]
* user_interest[] = [:desired_interest_id]
* user_interest[] = [:desired_interest_id]
* ...

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' -H 'Authorization: Token token=0MJCmIu6vxzQtFr_AOWf5w' -X POST 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/edit_my_interests' -F "user_interests[]=10" -F "user_interests[]=9"
```

Answer:

```
{"success":true,"message":"UserInterests were successfully updated."}

or

{"success":false,"message":"No user interests detected."}

or if the token is damaged

{"success":false,"message":"Something's wrong with the auth_token. Current_user is nil."}
```


---


##Activities

###10. Create activity

**POST** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/activities

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token]'

*Body:*

* name
* location
* time (datetime)
* nrofpeopleinvited

**Returns: json**

### Terminal example

```
$ curl -H 'Content-Type: multipart/form-data' -H 'Accept: application/json' -H 'Authorization: Token token=0fxLFtgI1oj8IYsFV6HB5w' -F "activity[name]=Dog chase" -F "activity[location]=Parcul Tineretului" -F "activity[time]=2015-03-20T06:50:37.283Z" -F "activity[nrofpeopleinvited]=2" 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/activities'
```

Answer:

```
{
	"id":4,
	"name":"Dog chase",
	"user_id":1,
	"location":"Parcul Tineretului",
	"time":"2015-03-20T06:50:37.283Z",
	"nrofpeopleinvited":2,
	"created_at":"2015-03-15T07:16:00.416Z",
	"updated_at":"2015-03-15T07:16:00.416Z"
}
```


---


###11. My activities

*returns 2 json arrays - the first one has the activities I created, even if I am not going to them - and the second one has all the activities I am going to*

**GET** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/my_activities

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token]'

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' -H 'Authorization: Token token=0fxLFtgI1oj8IYsFV6HB5w' GET 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/my_activities'
```

Answer:

```
{
	"activities_i_created!":
	[
		{"id":3,"name":"Light Jogging","location":"Parcul Tineretului","time":"2015-03-20T06:50:37.283Z","nrofpeopleinvited":2},
		{"id":5,"name":"Kite flying","location":"Malul Marii Negre","time":"2015-03-20T06:50:37.283Z","nrofpeopleinvited":2}
	],
	"activities_im_going_to!":
	[
		{"id":3,"name":"Light Jogging","user_id":1,"location":"Parcul Tineretului","time":"2015-03-20T06:50:37.283Z","nrofpeopleinvited":2},
		{"id":5,"name":"Kite flying","user_id":1,"location":"Malul Marii Negre","time":"2015-03-20T06:50:37.283Z","nrofpeopleinvited":2},
		{"id":9,"name":"Tennis Championship Attend","user_id":6,"location":"Wimbledon, London","time":"2015-03-19T06:52:00.000Z","nrofpeopleinvited":7}
	]
}
```


---


###12. My feed

*returns the activities of those people with 2 or more interests in common with current_user*

**GET** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/my_feed

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token]'

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' -H 'Authorization: Token token=0fxLFtgI1oj8IYsFV6HB5w' GET 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/my_feed'
```

Answer:

```
[
	{"id":7,"name":"Play Go","user_id":5,"location":"BCU","time":"2015-03-20T06:50:00.000Z","nrofpeopleinvited":3},
	{"id":8,"name":"Kafka books discussion","user_id":5,"location":"BCU","time":"2015-03-18T06:51:00.000Z","nrofpeopleinvited":7},
	{"id":9,"name":"Tennis Championship Attend","user_id":6,"location":"Wimbledon, London","time":"2015-03-19T06:52:00.000Z","nrofpeopleinvited":7}
]
```


---


###13. Edit activity

**PATCH** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/activities/[:id]

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token_of_activity_owner]'

*Body:*

At least one of these attributes

* name
* location
* time
* nrofpeopleinvited

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' -X PATCH 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/activities/2' -H 'Authorization: Token token=0fxLFtgI1oj8IYsFV6HB5w' -d 'activity[location]=Strada cu Pisici'
```

Answer:

```
{"success":true,"message":"Activity was successfully updated."}
```


---


###14. Delete activity

**DELETE** http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/activities/[:id]

*Header:*

* **Content-Type:** application/json
* **Accept:** application/json
* **Authorization:** Token token=[:auth_token_of_activity_owner]'

**Returns: json**

### Terminal example

```
$ curl -H 'Accept: application/json' -X DELETE 'http://penginapi-env-3cza7gecmy.elasticbeanstalk.com/activities/4' -H 'Authorization: Token token=0fxLFtgI1oj8IYsFV6HB5w'
```

Answer:

```
{"success":true,"message":"Activity was successfully destroyed."}
```


