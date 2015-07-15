# API

## Overview

All access is over HTTPS, and access from the https://protected-scrubland-4220.herokuapp.com/ domain. All data is sent and received as JSON.

## Access Token

Assume that every request requires an access token unless stated otherwise. The access token must be provided in the header.

To do this make sure you set 'Access-Token' equal to the user's access token in every required request.

`['Access-Token'] = 'f16395873f4bcee7ef5d46e531b9f659'`

### Unauthorized

If a user is unauthorized to make a request the following json response will be given:

```json
Response Status Code: 401

{
  "message": "Access-Token not found."
}
```

## Sign up, Login, User profile and Delete user

### New user registration

Access-Token:    *Not required.*

Path: `POST '/users/signup'`

Parameters:

| name       | type   | description                              |
|------------|--------|------------------------------------------|
| username   | string | username for user to be created          |
| password   | string | password has to be at least 8 characters |
| first_name | string | first name of user to be created         |
| last_name      | string | last of user to be created              |
| email      | string | email to be created              |


Example data successful response:

```json
Response Status Code: 200

{
  "username": "testuser3",
  "first_name": "Joe",
  "last_name": "Hello",
  "email": "test3@gmail.com",
  "access_token": "f16395873f4bcee7ef5d46e531b9f659"
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "errors": [
    "Password can't be blank",
    "Email can't be blank",
    "Email is not a valid email.",
    "User name can't be blank",
    "First name can't be blank",
    "Last name can't be blank"
  ]
}

```

### User login

Access-Token: *Not required.*

Path:
`POST '/users/login'`

Parameters:

| name     | type   | description                                                 |
|----------|--------|-------------------------------------------------------------|
| username | string | username for the user you want get authentication key for   |
| password | string | password for the user you want get authentication token for |

Example data successful response:

```json
Response Status Code: 200

{
  "username": "testuser3",
  "access_token": "f16395873f4bcee7ef5d46e531b9f659"
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "message":"The username or password you supplied is incorrect."
}
```

### Get current user profile

Access-Token: *Required.*

Path: `GET '/users/profile'`

Example data successful response:

```json
Response Status Code: 200

{
  "username": "dsfasdf",
  "first_name": "Joe",
  "last_name": "Hello",
  "email": "whattt@sup.com",
  "avatar": "https://hello.com/somepic.jpg"
}
```

Example data failure response:

```json
Response Status Code: 404

{
  "message": "There is no user to display."
}
```
Or if access token is wrong or empty:

```json
Response Status Code: 401

{
  "message":"Access-Token not found."
}
```

### Update current user profile

Access-Token: *Required.*

Path:
`PUT '/users/profile'`

Parameters:

| name       | type   | description                              |
|------------|--------|------------------------------------------|
| email   | string | email user wants to use, has to be unique   |
| first_name   | string | first name of user          |
| last_name   | string | last name of user          |
| avatar | file | image file for avatar, jp(e)g, png |



Example data successful response:

```json
Response Status Code: 200

{
  "username": "dsfasdf",
  "first_name": "Joe",
  "last_name": "Hello",
  "email": "whattt@sup.com",
  "avatar": "https://hello.com/somepic.jpg"
}
```

Example data failure response:

```json
Response Status Code: 404

{
  "message": "There is no user to display."
}
```
Or if access token is wrong or empty:

```json
Response Status Code: 401

{
  "message": "Access-Token not found."
}
```

###Change password

Access-Token: *Required.*

Path:
`PUT '/users/password'`

Parameters:

| name       | type   | description                              |
|------------|--------|------------------------------------------|
| password   | string | password confirmation to delete user     |
| new_password   | string | password confirmation to delete user     |

Example data successful response:

```json
Response Status Code: 200

{
  "message": "Password has been changed."
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "message": "Password has been changed."
}
```

Or:

```json
Response Status Code: 422

{
  "message": "New password is invalid."
}
```

Or:

```json
Response Status Code: 422

{
  "message": "Password you supplied is not correct."
}
```


###Delete a User

Access-Token: *Required.*

Path:
`DELETE '/users/delete'`

Parameters:

| name       | type   | description                              |
|------------|--------|------------------------------------------|
| password   | string | password confirmation to delete user     |

Example data successful response:

```json
Response Status Code: 200

{
  "message": "User has been deleted."
}
```

## Classroom stuff

### Create a classroom

Access-Token: *Required.*

Path:
`POST '/classrooms/create'`

Parameters:

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| name   | string | name of the classroom you want to create, has to unique    | required |
| description   | string | description of the classroom you want to create    | not required |
| language | string | language that the classroom belongs to eg. "spanish" | required |
| avatar | file | avatar for classroom, will default to a specific image | not required |


Example data successful response:

```json
Response Status Code: 200

{
  "id": 15,
  "name": "spanish",
  "description": "this is my class",
  "avatar": "hello",
  "user": {
    "username": "hello12",
    "role": "teacher"
  }
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "errors": [
    "Name has already been taken",
    "Code can't be blank"
  ]
}
```

Or:

```json
Response Status Code: 422

{
  "message": "Language doesn't exist"
}
```

### Show a specific classroom

This endpoint allows you get classroom information at two different levels of detail depending on if the user is part of the classroom or not. You'll find visibility_type at the bottom of the json response for your convenience. It will either be detailed or basic.

Access-Token: *Required for Detailed view* *Not Required for basic view.*

Path: `GET '/classrooms/:id'`

Example data successful response if current user is a student or teacher of class:

```json
Response Status Code: 200

{
  "id": 15,
  "name": "hello",
  "description": "this is my class",
  "language": "spanish",
  "num_teachers": 1,
  "num_students": 3,
  "teachers": [
    {
      "id": 18,
      "username": "hello12",
      "first_name": "rick",
      "last_name": "sun",
      "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
      "role": "teacher"
    }
  ],
  "students": [
    {
      "id": 46,
      "username": "hello21232222222222222322222324422222224562",
      "first_name": "rick",
      "last_name": "sun",
      "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
      "role": "student"
    },
    {
      "id": 7,
      "username": "hello",
      "first_name": "rick",
      "last_name": "sun",
      "avatar": "http://unoverb-dev.s3.amazonaws.com/users/avatars/000/000/007/original/Screen_Shot_2015-06-30_at_9.19.53_AM.png?1436214265",
      "role": "student"
    },
    {
      "id": 47,
      "username": "test",
      "first_name": "rick",
      "last_name": "sun",
      "avatar": "http://unoverb-dev.s3.amazonaws.com/users/avatars/000/000/047/original/missing.png?1436564914",
      "role": "student"
    }
  ],
  "visibility_type": "detailed"
}
```

Example data successful response if user/visitor not part of class:

```json
{
  "id": 15,
  "name": "hello",
  "description": "this is my class",
  "language": "spanish",
  "num_teachers": 1,
  "num_students": 3,
  "visibility_type": "basic"
}
```

### Show a list of classrooms

Access-Token: *Not Required.*

Path:
`GET '/classrooms'`

Parameters:

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| sort_by   | string | valid options: "new", "top"   | Required|
| language | string | specify language | Required |

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 15,
    "name": "hello",
    "description": "this is my class",
    "language": "spanish",
    "num_participants": 4
  },
  {
    "id": 13,
    "name": "joe likes fish",
    "description": "this is my class",
    "language": "spanish",
    "num_participants": 1
  }
]

```

Example data failure response:

```json
Response Status Code: 422

{
  "message": "Language does not exist."
}

```

Or:

```json
Response Status Code: 422

{
  "message": "Not a valid sort_by parameter."
}
```

