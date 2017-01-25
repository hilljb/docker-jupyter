# docker-jupyter

Dockerized Jupyter notebooks (Python, R, Spark) for data science explorations.

## Introduction

Several Dockerfiles are included:

* `base-jupyter`: Contains the base Debian (stretch) system and everything to run a Jupyter Notebook server.
* `r-jupyter`: Extends `base-jupyter` with the R kernel, several R packages, and the [ISLR](http://www-bcf.usc.edu/~gareth/ISL/) library.

## Installation

To build any of the images, run the build script in that image's folder. The `base-jupyter` image must first be built and available on your system to build any other image.

## Running

Use the `run.sh` script in the corresponding image's folder. Two external folders will be mounted into the running container, and by default they are both `$HOME`. They are modified with the following options.
* `-w|--workdir`: Jupyter's working directory. This becomes `/opt/workdir` in the container.
* `-d|--datadir`: A directory where data is stored. This becomes `/opt/datadir` in the container.
These options are useful for organization's sake, and also in the case when a working or data directory isn't located under your `$HOME` directory.

Once inside the container, execute the `start-notebook.sh` script, which is in the root user's `$PATH`. This will start Jupyter and provide a hash string. This string is required for security purposes in order to access the notebook. Copy and paste the provided link into your browser. (In the case of a remote server, replace `localhost` with the appropriate IP address.

## Known Issues
