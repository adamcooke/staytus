# Using Staytus with Docker

Staytus can be run using Docker. Please be aware that Docker support is not officially supported by me as I have no direct experience using it and relies on others to provide appropriate pull requests in order to maintain compatibility.

## Setup with Docker

1. [Install Docker](https://docs.docker.com/installation/) and [docker-compose](https://docs.docker.com/compose/install/)
2. Download the `docker-compose.yml` file.
3. Navigate into the folder with the `docker-compose.yml`.
4. Run `docker-compose up`. Now it should start to pull the database and staytus image.
5. Go to [http://localhost:80](http://localhost:80) and follow the instructions to configure Staytus

This will pull and start the latest published Staytus Docker image, and start it listening on port 80 on the host machine.

Note that this container includes two persistent volumes, one for the database (persisting all config and state) and one for persistent DB config.

### Upgrading with Docker

When a new Staytus Docker image is published that you'd like to upgrade to:

1. Stop your current Staytus container with `docker-compose stop` and `docker-compose rm`.
2. Pull the new image version `docker pull adamcooke/staytus`.
3. Follow step 4 to 5 from [Setup with Docker](#setup-with-docker)

This will automatically migrate your DB to pick up any new changes, and bring in any new code changes from the Staytus code.

## Changing the port
Just edit the `docker-compose.yml` and change the line:
```
[...]
  ports:
    - "80:5000" # <-- This line
  environment:
[...]
```
