# README

Steps to get the application up and running:

* Add to the project folder .env and config/master.key files

* Build the container:
  docker-compose build

* Boot the app with docker-compose up:
  docker-compose up

* Create the database: 
  docker-compose run web rake db:create
  
* View the rails welcome page:
  http://localhost:3000
  
  
To login to the container as bash console:
  docker-compose run --rm web bash
  
  
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
 
 API documentation:
 http://localhost:3000/swagger
  