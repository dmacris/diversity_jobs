# About this project

This an template project for future development of Ruby on Rails applications, running in a Docker container

## Requirements

To run this project you will need to have:

- Docker (v23.0.1 or above)
- Docker compose (v2.16.0 or above)

## Environment

This project is using the following version of softwares:

- Ruby 3.2.1
- Postgresql 12.14-1.pgdg110+1

## Setup

### Setup a `.env` file

On the root directory, create a `.env` file.
The file can be empty, but if you are using linux you should follow the instructions below.

### User id and group id

On a terminal, use the command `id`

You should get a response like

```
uid=1000(user-name) gid=1000(user-name), groups=....
```

**If** your uid and gid are not 1000, you should fill up the `.env` file with the following lines:

```
GID=`Number that you got from the id command`
UID=`Number that you got from the id command`
```

### The initial-setup.sh script

Call the `initial-setup.sh` to configure de docker network at the first time you will run this project

### Running

To run the application, just use

`docker compose up app`

Then the server should be find in the localhost:3010

### Commands inside the container

To access the terminal inside the container, run:

`docker compose run --rm app bash`

### What you can customize

In this project you might want to create a .env file, this file will affect the variables defined in the `docker-compose.yml`.

#### Customizable variables

| Variable name | What it does |
| :--- | :----------- | 
| RAILS_ENV | Changes the env `RAILS_ENV` variable that is passed to the service containers, defaults to `development` | 
| WAIT_FOR_TIMEOUT | Sets the amount of time in seconds that the `wait-for-it` command will wait for the postgres and rabbitmq services, if the default is not sufficient for you machine, you might want to increase it | 
| PG_PWD* | Sets the password for the postgres service container and also passes it to the other services containers |

\* if you change those after the `postgres` service were create as container, the change might not be 
reflected because of the volumes created for this service, you may need to remove the container, delete the volumes
 and recreate they.

## Word of caution

The `dotenv-rails` gem do not override any variables that were set by the local ENV, that means that all the variables
that are set in the `environment` block in the `docker-compose.yml` file cannot be changed for a particular service via
a local `dotenv` file. But they are mostly used to access the services like `postgres` and should not be an issue.

