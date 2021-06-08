# Docker Sinatra application example
As you will seen this is only a dockerized Sinatra application example



## Getting Started

Just use the makefile, it will guide you through the operations

```bash
make help

Usage:
  make <target>

Targets:
 help             Shows this pretty screen
 docker/build     Builds the Docker image
 docker/run       Runs the compose scenario
 docker/stop      Runs the compose scenario
```

To run the demo you should follow these steps

1. Make the docker image

   ```bash
   make docker/build
   ```

2. Run the Docker compose scenario:

   ```bash
   make docker/run
   ```

3. Test the application

   ```bash
   curl -s http://localhost:4567/counter | jq
   ```

   
