# Geo Service Application

## About

This is a Ruby on Rails API based application, which helps to find nearby users based on given longitude, latitude, and range. When these parameters are not passed then it will take default longitude, the latitude of berlin office, and range as 100 km.

I have PostGIS to storing & querying the GPS-based data.

## System dependencies

1. `Ruby 2.7.1`
2. `Rails 6.0.3`
3. `Postgres`
4. `Postgis`
5. `Docker for Mac`

## Development Setup

- Build Docker

`docker-compose build`

- Database creation

`docker-compose run web rake db:setup`

- Start the Application
    `docker-compose up`

## How to run the test suite

`docker-compose run -e RAILS_ENV=test web rspec`

## User

This model is used to represent a user & had fields required for storing user data with location.

### Implementation Logic

I am doing a few things to find all nearby users for food & drinks.
So, the steps can be summarized as follows.

1. Loading all data from JSON file to database using seeder with PostGIS support.

2. Upon receiving any web request for `api/users`, we are firing `Geo::UserFinderService` to filter the nearby users.

3. `Geo::UserFinderService` does a database query using request params or default params with the help of `ST_Distance` method of `PostGIS` than doing an order by on `user_id` column.

4. At last, we are returning the user's data in the `JSON` format.

## Patterns of Development

I personally try to keep things simple and small as much as possible. I am a fan of DRY but don't like to go super dry.

Btw I am a good believer in the single responsibility principle & prefer to have a number of classes instead of having a giant single class.

### Services

Services are PORO and used to perform the operation which is not suitable for model and controller and must adhere to the single responsibility principle.

I prefer to expose only one endpoint from the service that would be invoked.

#### app/services/geo/\*

This directory is going to all services related to geo.

`Geo::UserFinderService` is used to finding all nearby users of given filter params, if params are missing then uses the
default values.

#### app/services/importer/user_importer_service.rb

I prefer to create a service for importing seed data because we can test it and it's more manageable than normal `seeds.rb`.

## API CURL

### API for getting nearby users

```
curl --location --request GET 'http://localhost:3000/api/users' \
--header 'Content-Type: application/json'
```

The response of the above curl command.

```
{
  "users": [
    {
      "name": "Ernesto Breitenberg",
      "user_id": 4
    },
    {
      "name": "Nolan Little",
      "user_id": 6
    },
    {
      "name": "Burt Klein Esq.",
      "user_id": 14
    },
    {
      "name": "Eldridge Funk DDS",
      "user_id": 19
    },
    {
      "name": "Maggie Trantow",
      "user_id": 25
    },
    {
      "name": "Arden Kshlerin",
      "user_id": 29
    },
    {
      "name": "Candi Larkin",
      "user_id": 30
    },
    {
      "name": "Blondell Hermiston",
      "user_id": 35
    },
    {
      "name": "Kemberly Durgan DC",
      "user_id": 36
    },
    {
      "name": "Rafael Streich IV",
      "user_id": 40
    },
    {
      "name": "Raymundo Schuster",
      "user_id": 42
    },
    {
      "name": "Cole Predovic JD",
      "user_id": 49
    }
  ]
}
```

## Deployment instructions

- `git push heroku master`
