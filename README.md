# Bowling Challenge

## Stack

* `ruby 2.7.1`
* `rails 6.0.3`
* `Docker`
* `rubocop`

## About

The challenge is to score a 10-pin bowling game and print on terminal by receiving a txt file and treating it.

## Getting started

To run the project ensure that you have docker and docker-compose installed and follow this instructions:

```bash
# add .env to project
mv .env.sample .env

# build project
docker-compose build

# start the server
docker-compose up

# to access the container run
docker-compose exec web bash
```

## Testing

Inside the web container run:

```bash
# choose a txt file allocated in ./public/
rails runner 'Bowling.new.call' < ./public/normal_game.txt
 
# bonus scenarios
rails runner 'Bowling.new.call' < ./public/perfect_game.txt
rails runner 'Bowling.new.call' < ./public/foul_game.txt
```