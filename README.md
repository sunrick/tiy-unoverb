# API

## Overview

All access is over HTTPS, and access from the "https://protected-scrubland-4220.herokuapp.com/" domain. All data is sent and received as JSON.

## Access Token

Assume that every request requires an access token unless stated otherwise. The access token must be provided in the header.

To do this make sure you set 'Access-Token' equal to the user's access token in every required request.

```
['Access-Token'] = 'f16395873f4bcee7ef5d46e531b9f659'
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

```
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
    "Full_name can't be blank"
  ]
}

```

### User login

Access-Token:
* Not required.*

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

Access-Token:
*Required.*

Path: `GET '/users/profile'`

Example data successful response:

```json

{
  "username": "dsfasdf",
  "first_name": "Joe",
  "last_name": "Hello"
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

```
Response Status Code: 401

{
  "message":"Access-Token not found."
}
```

### Update current user profile

Access-Token:
*Required.*

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

{
  "username": "dsfasdf",
  "first_name": "Joe",
  "last_name": "Hello"
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

```
Response Status Code: 401

{
  "message": "Access-Token not found."
}
```

###Delete a User

Access-Token:
*Required.*

Path:
`DELETE '/user'`

Example data successful response:

```
{
  "message": "Account deleted."
}
```
