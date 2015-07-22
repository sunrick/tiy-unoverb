# API

## Table of Contents
1. [Overview](#overview)
  * [Access Token](#access-token)
  * [Unauthorized](#unauthorized)
2. [User Routes](#user-routes)
  * [New user registration](#new-user-registration)
  * [Get current user profile](#get-current-user-profile)
  * [Update current user profile](#update-current-user-profile)
  * [Change password](#change-password)
  * [Delete a user](#delete-a-user)
3. [Classroom routes](#classroom-routes)
  * [Create a classroom](#create-a-classroom)
  * [Show a specific classroom](#show-a-specific-classroom)
  * [Show a list of classrooms](#show-a-list-of-classrooms)
  * [Update a classroom](#update-classroom)
  * [Delete a classroom](#delete-classroom)
  * [Get classrooms for a user](#get-classrooms-for-a-user)
  * [Send join request to classroom](#send-join-request-to-classroom)
  * [Get requests to join classroom](#get-requests-to-join-classroom)
  * [Process a join request](#process-a-join-request)
  * [User role in a classroom](#user-role-in-a-classroom)
4. [Exercise routes](#exercise-routes)
  * [Create an exercise for a classroom](#create-an-exercise-for-a-classroom)
  * [Get exercises for a classroom](#get-exercises-for-a-classroom)
  * [Get an exercise](#get-an-exercise)
  * [Delete an exercise](#delete-an-exercise)
  * [Update an exercise](#update-an-exercise)
5. [Question routes](#question-routes)
  * [Create questions for an exercise](#create-questions-for-an-exercise)
  * [Get all questions for an exercise](#get-all-questions-for-an-exercise)
  * [Get a question for an exercise](#get-a-question-for-an-exercise)
  * [Update a question for an exercise](#update-a-question-for-an-exercise)
  * [Delete a question for an exercise](#delete-a-question-for-an-exercise)
6. [Game routes](#game-routes)
  * [Play a new game](#play-a-new-game)
  * [Save a game](#save-a-game)
7. [Verb routes](#verb-routes)
  * [Search verbs](#search-verbs)
8. [Tense routes](#tense-routes)
  * [Get all tenses](#get-all-tenses)
9. [Form routes](#form-routes)
  * [Get all forms](#get-all-forms)
10. [Score routes](#score-routes)
  * [Get scores for a specific exercise](#get-scores-for-a-specific-exercise)
  * [Get scores for a specific question](#get-scores-for-a-specific-question)
  * [Get scores for a specific game](#get-scores-for-a-specific-game)

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

## User Routes

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
Response Status Code: 201

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

## Classroom routes

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
Response Status Code: 201

{
  "id": 17,
  "name": "hello44",
  "description": "hello hello",
  "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
  "language": "spanish",
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
    "Name has already been taken"
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
  "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
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
  "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
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
| sort_by   | string | valid options: "new", "top"   | required|
| language | string | specify language | required |
| page | integer | get page of 25 results | not required |

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 15,
    "name": "hello",
    "description": "this is my class",
    "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
    "language": "spanish",
    "num_participants": 4
  },
  {
    "id": 13,
    "name": "joe likes fish",
    "description": "this is my class",
    "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
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
### Update a classroom

Access-Token: *Required.*

Path: `PUT '/classrooms/:id'`

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
  "id": 17,
  "name": "hello44",
  "description": "hello hello",
  "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
  "language": "spanish",
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
    "Name has already been taken"
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

### Delete a classroom

Access-Token: *Required.*

Path: `DELETE '/classrooms/:id'`

```json
Response Status Code: 200

{
  "message": "Classroom deleted."
}
```

### Get classrooms for a user

Access-Token: *Required.*

Path: `GET 'user/classrooms/'`

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 13,
    "name": "hello",
    "description": "this is my class",
    "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
    "language": "spanish",
    "role": "teacher"
  },
  {
    "id": 17,
    "name": "hello44",
    "description": "hello hello",
    "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
    "language": "spanish",
    "role": "student"
  }
]
```

### Send join request to classroom

Access-Token: *Required.*

Path: `POST 'classrooms/:id/join'`

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| message   | string | message that the user wants to send with request    | not required |
| role   | string | has to be "teacher", or "student"   | required |

Example data successful response:

```json
Response Status Code: 201

{
  "request_id": 4,
  "message": "hey i want to join your class",
  "username": "user2",
  "classroom": "classroom1"
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "message": "You have already tried to join this class or you are already part of it!"
}
```

### Get requests to join classroom

Access-Token: *Required.*

Path: `GET 'classrooms/:id/requests'`

Example data successful response:

```json
Response Status Code: 200

[
  {
    "request_id": 4,
    "message": "hey i want to join your class",
    "user": {
      "username": "user2",
      "first_name": "hello hello",
      "last_name": "spanish",
      "email": "rick1234@rick1234.com",
      "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png"
    }
  },
  {
    "request_id": 5,
    "message": "hey i also want to join your class",
    "user": {
      "username": "user3",
      "first_name": "something",
      "last_name": "spanish",
      "email": "rick1234@rick1234.com",
      "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png"
    }
  }
]
```

### Process a join request

Access-Token: *Required.*

Path: `POST 'requests/:id'`

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| accept   | string | either "yes" or "no"   | required |

Example data successful response:

```json
Response Status Code: 200

{
  "id": 50,
  "username": "user2",
  "first_name": "hello hello",
  "last_name": "spanish",
  "email": "rick1234@rick1234.com",
  "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png",
  "role": "student"
}

Or:

{ 
  "message": "Request deleted."
}
```

Example data failure response:

```json
Response Status Code: 422

{ 
  "message": "Check your accept parameter."
}
```

### User role in a classroom

Access-Token: *Required.*

Example data success response: 200

```json
  Response Status Code:
  POSSIBLE USER TYPES: "teacher", "student"

  {
    "user_type": "teacher"
  }
```

## Exercise Routes

### Create an exercise for a classroom

Access-Token: *Required.*

Path: `POST 'classrooms/:id/exercise'`

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| name   | string | name of the exercise   | required |
| description   | string | description of the exercise   | not required |

Example data successful response:

```json
Response Status Code: 201

{
  "id": 3,
  "name": "hello2",
  "description": null,
  "classroom": {
    "id": 20,
    "name": "classroom1",
    "description": "hello hello"
  }
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "errors": [
    "Name has already been taken"
  ]
}
```
### Get exercises for a classroom

Access-Token: *Required.*

Path: `GET 'classrooms/:id/exercises'`

Example data successful response:

```json
Response Status Code: 200

[
  {
    "id": 1,
    "name": null,
    "description": null
  },
  {
    "id": 2,
    "name": "hello",
    "description": null
  }
]
```

### Get an exercise

Access-Token: *Required.*

Path: `GET 'exercises/:id'`

Example data successful response:

```json
Response Status Code: 200

{
  "id": 2,
  "name": "hello23",
  "description": "yooo",
  "classroom": {
    "id": 20,
    "name": "classroom1",
    "description": "hello hello"
  }
}
```
### Delete an exercise

Access-Token: *Required.*

Path: `DELETE 'exercises/:id'`

Example data successful response:

```json
Response Status Code: 200

{
  "message": "Exercise destroyed."
}
```
### Update an exercise

Access-Token: *Required.*

Path: `PUT 'exercises/:id'`

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| name   | string | name of the exercise   | required |
| description   | string | description of the exercise   | not required |

```json
Response Status Code: 200

{
  "id": 2,
  "name": "hello23",
  "description": "yooo",
  "classroom": {
    "id": 20,
    "name": "classroom1",
    "description": "hello hello"
  }
}
```
## Question Routes

### Create questions for an exercise

Access-Token: *Required.*

Path: `POST 'exercises/:id/questions'`

Parameters:

You will have to post json data in this format for each question you want to create. Use the routes for Verbs, Forms, Tenses to get the available data to post. Make sure you include `Content-Type: application/json` in your headers.

```json
{
  "data" : 
  [
    {
      "form": "tu",
      "verb": "abandonar",
      "combined_tense_english": "Indicative Present"
    },
    {
      "form": "yo",
      "verb": "abandonar",
      "combined_tense_english": "Indicative Present"
    }
  ]
}
```

Example data successful response:

```json
Response Status Code: 201

[
  {
    "id": 1,
    "form": "tu",
    "verb": "abandonar",
    "combined_tense_english": "Indicative Present",
    "conjugation": "abandonas"
  },
  {
    "id": 2,
    "form": "tu",
    "verb": "abandonar",
    "combined_tense_english": "Indicative Present",
    "conjugation": "abandonas"
  }
]
```

### Get all questions for an exercise

Access-Token: *Required.*

Path: `GET 'exercises/:id/questions'`

```json
Response Status Code: 200

[
  {
    "id": 1,
    "form": "tu",
    "verb": "abandonar",
    "combined_tense_english": "Indicative Present",
    "conjugation": "abandonas"
  },
  {
    "id": 2,
    "form": "tu",
    "verb": "abandonar",
    "combined_tense_english": "Indicative Present",
    "conjugation": "abandonas"
  }
]
```

### Get a question for an exercise

Access-Token: *Required.*

Path: `GET 'questions/:id'`

```json
Response Status Code: 200

{
  "id": 72,
  "form": "tu",
  "verb": "hablar",
  "combined_tense_english": "Indicative Present",
  "conjugation": "hablas"
}
```

### Update a question for an exercise

Access-Token: *Required.*

Path: `PUT 'questions/:id'`

Parameters:

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| form   | string | check the form routes for possible strings   | required |
| verb   | string | check the verb routes for possible strings    | required |
| combined_tense_english   | string | check the form tense routes for possible strings | required |

```json
Response Status Code: 200

{
  "id": 72,
  "form": "tu",
  "verb": "hablar",
  "combined_tense_english": "Indicative Present",
  "conjugation": "hablas"
}
```

### Delete a question for an exercise

Access-Token: *Required.*

Path: `DELETE 'questions/:id'`

```json
{
  "message": "Question has been destroyed."
}
```

## Game routes

### Play a new game

This route shuffles the exercise into a random order.

Access-Token: *Required.*

Path: `GET 'exercises/:id/games/play'`

Example data successful response:

```json
Response Status Code: 200

[
  {
    "question_id": 59,
    "form": "yo",
    "verb": "hablar",
    "verb_english": "to speak",
    "combined_tense_english": "Indicative Present",
    "example_english": "I speak, am speaking",
    "answer": "hablo"
  },
  {
    "question_id": 22,
    "form": "yo",
    "verb": "comer",
    "verb_english": "to eat",
    "combined_tense_english": "Indicative Present",
    "example_english": "I eat, am eating",
    "answer": "como"
  }
]
```

### Save a game

Access-Token: *Required.*

Path: `POST 'exercises/:id/games/save'`

Parameters:

You will have to post json data in this format for each guess you want to save. Make sure you include `Content-Type: application/json` in your headers. Time is in seconds.

```json
{
"data":
  [
      {
          "question_id": 22,
          "guess": "comos",
          "time": 12
      },
      {
          "question_id": 22,
          "guess": "como",
          "time": 2
      }
  ]
}
```

Example data success response:

```json
Response Status Code: 201

{
  "game_id": 46
}
```

## Verb routes

### Search verbs

Access-Token: *Not Required.*

Path: `GET 'verbs'`

Parameters:

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| language  | string | for now "spanish"   | required |
| search | string | any valid string | required |

```json
Response Status Code: 200

{
  "verbs": [
    {
      "verb": "abandonar"
    },
    {
      "verb": "abordar"
    }
  ]
}
```

## Tenses routes

### Get all tenses

Access-Token: *Required.*

Path: `GET 'tenses'`

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| language  | string | for now "spanish"   | required |

```json
Response Status Code: 200

[
  {
    "combined_tense_english": "Indicative Present"
  },
  {
    "combined_tense_english": "Indicative Future"
  }
]
```

## Forms routes

### Get all forms

Access-Token: *Required.*

Path: `GET 'forms'`

| name       | type   | description                              | required? |
|------------|--------|------------------------------------------| ---------- |
| language  | string | for now "spanish"   | required |

```json
Response Status Code: 200

[
  {
    "form": "yo"
  },
  {
    "form": "tu"
  }
]
```

## Score Routes

### Get scores for a specific exercise

You will get a breakdown of an entire exercise question by question with the 5 most common mistakes students made on that conjugation along with the count.

Access-Token: *Required.*

Path: `GET 'exercises/:id/scores'`

```json
Response Status Code: 200

[
  {
    "question": {
      "id": 1,
      "form": "tu",
      "tense": "Indicative Present",
      "verb": "abandonar",
      "conjugation": "abandonas"
    },
    "score_data": {
      "attempts": 20,
      "correct": 10,
      "wrong": 10,
      "accuracy": 50.00,
      "top_time": 2,
      "slowest_time": 12,
      "avg_time": 11.42
    },
    "common_mistakes": [
      {
        "mistake": "abondas",
        "count": 10
      },
      {
        "mistake": "comos",
        "count": 3
      }
    ]
  },
  {
    "question": {
      "id": 4,
      "form": "tu",
      "tense": "Indicative Present",
      "verb": "comer",
      "conjugation": "comes"
    },
    "score_data": {
      "attempts": 0,
      "correct": 0,
      "wrong": 0,
      "accuracy": 0,
      "top_time": null,
      "slowest_time": null,
      "avg_time": null
    },
    "common_mistakes": []
  }
]
```
### Get scores for a sepcific question

Access-Token: *Required.*

Path: `GET 'games/:id/scores'`

```json
Response Status Code: 200

{
  "question": {
    "id": 22,
    "form": "yo",
    "tense": "Indicative Present",
    "verb": "comer",
    "conjugation": "como"
  },
  "score_data": {
    "attempts": 7,
    "correct": 4,
    "wrong": 3,
    "accuracy": 57.14285714285714,
    "top_time": 2,
    "slowest_time": 12,
    "avg_time": 9.142857142857142
  },
  "user_scores": [
    {
      "user": {
        "id": 49,
        "username": "user1",
        "first_name": "hello hello",
        "last_name": "spanish",
        "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png"
      },
      "attempts": 7,
      "correct": 4,
      "wrong": 3,
      "accuracy": 57.14285714285714,
      "top_time": 2,
      "slowest_time": 12,
      "avg_time": 9.142857142857142,
      "common_mistakes": [
        {
          "mistake": "comos",
          "count": 3
        }
      ]
    }
  ]
}
```

### Get scores for a specific game

```json
Response Status Code: 200

{
  "game": {
    "id": 34,
    "user": {
      "username": "user1",
      "first_name": "hello hello",
      "last_name": "spanish",
      "avatar": "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png"
    },
    "score": {
      "attempts": 2,
      "correct": 1,
      "wrong": 1,
      "accuracy": 50,
      "top_time": 2,
      "slowest_time": 12,
      "avg_time": 7
    }
  },
  "questions": [
    {
      "question_id": 22,
      "conjugation": "como",
      "verb": "comer",
      "form": "yo",
      "tense": "Indicative Present",
      "correct": false,
      "time": 12
    },
    {
      "question_id": 22,
      "conjugation": "como",
      "verb": "comer",
      "form": "yo",
      "tense": "Indicative Present",
      "correct": true,
      "time": 2
    }
  ]
}
```

