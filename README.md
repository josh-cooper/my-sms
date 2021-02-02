# my-sms

## Manual
Run docker compose file then install bundle and run rails server from my-sms directory.

## Development

Use [Docker](https://docs.docker.com/docker-for-windows/install/) to run in containers.

Once Docker is installed on your system, you can use the included vscode config to set everything up automatically or manually set up the environment via Docker compose:

### VSCode

Install vscode remote development extension (see https://code.visualstudio.com/docs/remote/containers).

Remote development config is stored in .devcontainer. Open folder in vscode and it will set up a complete dev environment automatically.

Once container is set up rails server will autostart and vscode will forward the internal port to one available.


### Run containers via docker compose:

Create container services from the repository root
```
docker-compose up
```

Bash into dev container
```
docker exec -it $(docker ps -f name=my-sms_rails  --format "{{.ID}}") /bin/bash
> 
```

Working from my-sms directory, install the bundle and run rails server
```
> cd my-sms/
> bundle
> rails server -p 3000:3000
```

Port 3000 is already forwarded in the compose config. Open `localhost:3000` in your browser.
