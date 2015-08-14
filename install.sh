#!/bin/bash

PREREQS="VirtualBox docker docker-machine docker-compose"

function check_for_executable {
  name=$1
  echo "Checking for $name..."
  location=$(which $1)
  if [ -z "$location" ]; then
    echo "Could not find executable $name. Please verify that it is available on your system."
    exit 1
  else
    echo "OK"
  fi
}

function install_prereqs {
  echo "Installing dependencies via homebrew"

  ./scripts/install_dependencies.sh

  for progname in $PREREQS; do
    check_for_executable $progname
  done

  echo "Dependencies installed correctly."
}

function create_machine {
  echo "Checking for 'dev' docker-machine."
  machine=$(docker-machine ls -q | egrep '^dev$')
  if [ -z "$machine" ]; then
    ./scripts/build_machine.sh
  else
    echo "'dev' docker-machine already present."
  fi
  docker-machine start dev
}

function setup_environment {
  echo "Installing environment information to your ~/.profile."
  echo "If you are using another file, copy the following into it:"
  environment=$(docker-machine env dev)
  echo "$environment"
  echo "$environment" >> ~/.profile
  echo "You will need to run the following command in order to use docker. New terminals will be correctly configured."
  echo "source ~/.profile"
}

install_prereqs
create_machine
setup_environment
