# Notes

There are a few things regarding implementation I would have done in a different way now that I got some hands on
experience with the tools I decided to use to make this project.

One thing would be to better utilise `dry-schema` in order to create DTOs with nested objects. At the moment, it is not
possible to create a quiz with answers for example, they would have to be created one by one and each would require a
separate HTTP request which is inefficient.

I also realised that PUT should actually also create the given entity if not found according to proper REST API standards,
however, I realised it too late and didn't implement it due to time constraints.

When it comes to authentication / authorization I decided to use a very simple version of sending user credentials to
each protected endpoint. I tried to get token based auth working but I had some issues with it and decided to use the simpler version.

# Documentation

## Gems

Gems used in this app can be found in the `app/Gemfile` directory. The main ones are `ActiveRecord` for the ORM,
`Sinatra` for the REST API.

## Database

The project requires a database to run. PostgreSQL is expected.

You can either provide your own in which case you'd have to adjust the configuration in
`app/config/database/database.yml` accordingly.

The other option is to use predefined docker-compose version of the database which can be done
with `docker-compose up -d`
from the `app/docker` directory.

To setup the database you can utilise the Rakefile located in the `app` directory. Commands available are

* `rake db:create`
* `rake db:migrate`
* `rake db:drop`
* `rake db:reset`
* `rake db:schema`

In order to use the database with this project, it is necessary to create and migrate the DB.

## Running the app

To run the app, go to the `app/config/server/` directory and execute `rackup config.ru`

## REST API 

There are 5 main entities which can be manipulated via the REST API. Their relations are

* `User 1..* Quiz`
* `Quiz 1..* Question`
* `Question 1..* Answer`
* `Quiz *..* Category`

There are endpoints for each entity, they accept and return JSON DTOs. Some of them also require authorization.

Authorization works the same for every endpoint that uses it. An endpoint uses it if it requires the `X-Credentials` 
header mentioned lower. This header should have the value of `base64(username:password` and the credentials need to correspond
(including transitively) to the owner of the entity - ie to delete an answer, the owner is fetched via the chain
Answer->Question->Quiz->User and that is the owner of this answer. Password also obviously has to match.

Note: The category controller has no authorization for simplicity; for actual usage there should be some form of it implemented.

### User

Create user 
```
POST /user

body
{
	"username": "string",
	"password": "string"
}

HTTP status responses 
 * 201 - user created
 * 400 - username already exists or required arguments missing
```

Get all users
```
GET /user

HTTP status responses
 * 200
```

Get user by id
```
GET /user/:id

HTTP status responses
 * 200
 * 404 - user with given id not found
```

Update user
```
PUT /user/:id
headers
 * X-Credentials: base64(username:password)
  
body
{
	"username": "string",
	"password": "string"
}  
  
HTTP status responses
 * 200 - updated
 * 400 - missing required params
 * 403 - unauthorized
 * 404 - user with given id not found
```

Delete user
```
DELETE /user/:id
headers
 * X-Credentials: base64(username:password)
  
HTTP status responses
 * 200 - deleted
 * 403 - unauthorized
 * 404 - user with given id not found
```
### Quiz

Create quiz
```
POST /quiz
headers
 * X-Credentials: base64(username:password)
 
body
{
	"name": "string",
	"description": "string",
	"user_id": 1,
	"category_ids": [1, 2, 9]   (optional)
}

HTTP status responses
 * 201 - created
 * 400 - missing required params
 * 403 - unauthorized
 * 404 - invalid user foreign key
```
 * note - non-existing category IDs are simply skipped and the quiz is persisted

Get all quizzes
```
GET /quiz

HTTP status responses
 * 200
```

Get quiz by id
```
GET /quiz/:id

HTTP status responses
 * 200
 * 404 - quiz with given id not found
```

Update quiz
```
PUT /quiz
headers
 * X-Credentials: base64(username:password)
 
body
{
	"name": "string",
	"description": "string",
	"category_ids": [1, 2, 9]   (optional)
}

HTTP status responses
 * 200 - updated
 * 400 - missing required params
 * 403 - unauthorized
```

Delete quiz
```
DELETE /quiz/:id
headers
 * X-Credentials: base64(username:password)
 
HTTP status responses
 * 200 - deleted
 * 403 - unauthorized
 * 404 - quiz with given id not found
```

Add category to quiz
```
PUT /quiz/:quiz_id/category/:category_id
headers
 * X-Credentials: base64(username:password)
 
HTTP status responses
 * 200 - updated
 * 403 - unauthorized
 * 404 - quiz / category with given id not found
```

Remove category from quiz
```
DELETE /quiz/:quiz_id/category/:category_id
headers
 * X-Credentials: base64(username:password)
 
HTTP status responses
 * 200 - updated
 * 403 - unauthorized
 * 404 - quiz / category with given id not found
```

### Question

Create question
```
POST /question
headers
 * X-Credentials: base64(username:password)

body 
{
	"question":"string",
	"quiz_id": 1
}

HTTP status responses
 * 201 - created
 * 400 - required arguments missing
 * 403 - unauthorized
```

Get all questions
```
GET /question

HTTP status responses
 * 200
```

Get question by id
```
GET /question/:id

HTTP status responses
 * 200
 * 404 - question with given id not found
```

Update question
```
PUT /question/:id
headers
 * X-Credentials: base64(username:password)

body 
{
	"question":"string",
}

HTTP status responses
 * 201 - created
 * 400 - required arguments missing
 * 403 - unauthorized
 * 404 - question with given id not found
```

Delete question
```
GET /question/:id
headers
 * X-Credentials: base64(username:password)
 
HTTP status responses
 * 200 - deleted
 * 404 - question with given id not found
```

### Answer

Create answer
```
POST /answer
headers
 * X-Credentials: base64(username:password)
 
{
    "answer":"string",
    "correct": true,
    "question_id": 2
}

HTTP status responses
 * 201 - created
 * 400 - required arguments missing
 * 403 - unauthorized
```

Get all answer
```
GET /answer

HTTP status responses
 * 200
```

Get answer by id
```
GET /answer/:id

HTTP status responses
 * 200
 * 404 - answer with given id not found
```

Update answer
```
PUT /answer/:id
headers
 * X-Credentials: base64(username:password)
 
body
{
    "answer":"string",
    "correct": true
}

HTTP status responses
 * 200
 * 400 - required arguments missing
 * 403 - unauthorized
 * 404 - answer with given id not found
```

Delete answer
```
DELETE /answer/:id
headers
 * X-Credentials: base64(username:password)
 
HTTP status responses
 * 200
 * 400 - required arguments missing
 * 403 - unauthorized
 * 404 - answer with given id not found
```

### Category

Create category
```
POST /category

body
{
	"name":"string",
	"description": "string"
}

HTTP status responses
 * 201 - created
 * 400 - required arguments missing
```

Get all categories
```
GET /category

HTTP status responses
 * 200
```

Get category by id
```
GET /category/:id

HTTP status responses
 * 200
 * 404 - category with given id not found
```

Update category
```
PUT /category/:id

body
{
	"name":"string",
	"description": "string"
}

HTTP status responses
 * 201 - created
 * 400 - required arguments missing
 * 404 - category with given id not found
```

Delete category
```
DELETE /category/:id

HTTP status responses
 * 200 - deleted
 * 404 - category with given id not found
```
