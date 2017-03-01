#!/bin/bash

USAGE="usage: run.sh [-d|--datadir datadir] [-w|--workdir workdir]"


# Set defaults
DATADIR="$HOME"
WORKDIR="$HOME"

#
while [[ $# -gt 0 ]]; do
    KEY="$1"
    case $KEY in
        -d|--datadir)
        DATADIR="$2"
        shift
        ;;
        -w|--workdir)
        WORKDIR="$2"
        shift
        ;;
        -h|help|-help|--help)
        echo $USAGE
        exit 0
        ;;
        *)
        ;;
    esac
    shift
done

# remove existing container if it is already running
if [[ "$(docker ps -a | grep -c "base-jupyter")" -gt "0" ]]; then
    echo "-- removing existing running container in 5 seconds (Ctrl+c to halt termination)"
    sleep 5
    docker rm -f base-jupyter
fi

# run it
echo "-- starting container base-jupyter"
echo "-- Jupyter will give you a URL. (Replace localhost with IP address if needed.)"
docker run \
    --name base-jupyter \
    --rm \
    -p 8888:8888 \
    -v $DATADIR:/opt/datadir \
    -v $WORKDIR:/opt/workdir \
    -it quay.io/hilljb/base-jupyter \
    start-notebook.sh
