# Creative Server Local Dev

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

### Seed the databases?

    ./scripts/seed.sh

### Stop the services?

CTRL-C in the window running docker-compose, or `docker-compose kill`

### Reset Kafka?

    ./scripts/reset_kafka.sh
