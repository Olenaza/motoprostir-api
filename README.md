# README

Steps to get the application up and running:

* Build the container:
  docker-compose build

* Boot the app with docker-compose up:
  docker-compose up

* Create the database: 
  docker-compose run web rake db:create
  
* View the rails welcome page:
  http://localhost:3000
  
  
To login to the container as bash console:
  docker-compose run --rm api bash
  
  
To access the PostgreSQL command line terminal through Docker:
  docker exec -it motoprostir_db psql -U postgres
  This command runs the psql command under the user postgres.
  Connecting to a database:
  \c motoprostir_development
  Viewing the tables:
  \d
  Check the details of a particular table:
  \d+ users
  Exiting the container:
  \q
  
  
Request for authentication:
  curl -H "Content-Type: application/json" -X POST -d '{"email":"example1@gmail.com", "password":"123456"}' http://localhost:3000/authenticate
Returns:
  {"auth_token":<token>}
Prepend the token to the headers of the subsequent requests:
  curl -H "Authorization: <token>" http://localhost:3000/events
  