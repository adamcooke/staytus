# Using Staytus with Docker

Staytus can be installed/run using Docker. Please be aware that Docker support is not officially supported by me as I have no direct experience using it and relies on others to provide appropriate pull requests in order to maintain compatibility. In an ideal world, Docker would be moved out of this repository entirely and maintained by someone with the appropriate experience.

## Setup with Docker

1. [Install Docker locally](https://docs.docker.com/installation/)
2. Run `docker run -d -p 0.0.0.0:80:5000 --name=staytus adamcooke/staytus`
3. Go to [http://localhost:80](http://localhost:80) and follow the instructions to configure Staytus

This will pull and start the latest published Staytus Docker image, and start it listening on port 80 on the host machine.

Note that this container includes two persistent volumes, one for the database (persisting all config and state) and one for persistent DB config.

### Upgrading with Docker

When a new Staytus Docker image is published that you'd like to upgrade to:

1. Stop your current Staytus container with `docker stop staytus`
2. Rename your previous container with `docker rename staytus staytus-old`
3. Start a new container, reusing your previous volumes, with `docker run -d -p 0.0.0.0:80:5000 --name=staytus --volumes-from=staytus-old adamcooke/staytus`
4. Delete the old container with `docker rm staytus-old`

This will automatically migrate your DB to pick up any new changes, and bring in any new code changes from the Staytus code.
