# docker-jupyter

Dockerized Jupyter notebooks (Python, R, Spark) for data science explorations.

## Introduction

Several Dockerfiles are included:

* `base-jupyter`: Contains the base Debian (stretch) system and everything to run a Jupyter Notebook server.
* `r-jupyter`: Extends `base-jupyter` with the R kernel, several R packages, and the [ISLR](http://www-bcf.usc.edu/~gareth/ISL/) library.

## Installation

To build any of the images, run the build script in that image's folder. The `base-jupyter` image must first be built and available on your system to build any other image.

## Running

Use the `run.sh` script in the corresponding image's folder. Two external folders will be mounted into the running container, and by default they are both your host's `$HOME`. They are modified with the following options.
* `-w|--workdir host_directory_path`: Jupyter's working directory. This becomes `/opt/workdir` in the container.
* `-d|--datadir host_directory_path`: A directory where data is stored. This becomes `/opt/datadir` in the container.
These options are useful for organization's sake, and also in the case when a working or data directory isn't located under your `$HOME` directory.

Once inside the container, execute the `start-notebook.sh` script, which is in the root user's `$PATH`. This will start Jupyter and provide a hashed URL where you can access the notebook server. This string is required for security purposes in order to access the notebook. Copy and paste the provided link into your browser. (In the case of a remote server, replace `localhost` with the appropriate IP address.

## Known Issues

* If a browser is already running and attempting to contact the host on port 8888, the notebook server may ask for a password. If this happens, restart the container while ensuring that any existing browser tabs pointing at the server are closed.
* I'd love to include `start-notebook.sh` as the entry command for the images, but this seems to cause the exact same issue as the previous point: Jupyter asks for a password. I have no idea why this is the case. If I can debug this at some point, I'll make the notebook servers automatically start when the container is loaded.
