# Analytic Platform Local Dev

 Shamelessly cloned from Brian Murphy's creative-server-local-dev with a thousand thanks.

## How do I...

### Install dependencies?

First, you must have homebrew. Then, invoke this:

    ./scripts/install_dependencies.sh

### Create a new local dev machine?

    ./scripts/build_machine.sh

### Configure my environment?

Use this command:

    eval "$(docker-machine env dev)"

To automatically set this up, paste that line into your `.profile`. This will enable you to use `docker`
commands normally.

### Start up the services?

First, ensure you are in the directory creative-server-local-dev.

    ./start.sh
    
Note: for WebHdfs to work this entry must be put into the /etc/hosts file
The new entry maps the server name in docker-compose.yml
with the IP of the docker-machine.

> sudo vi /etc/hosts
....
192.168.99.103  dockerhadoop 
