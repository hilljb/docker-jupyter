# docker-jupyter

Dockerized Jupyter notebooks (Python, R, Spark) for data science explorations.

## Introduction

Several Dockerfiles are included:

* `base-jupyter`: Contains the base Debian (stretch) system and everything to run a Jupyter Notebook server.
* `r-jupyter`: Extends `base-jupyter` with the R kernel, several R packages, and the [ISLR](http://www-bcf.usc.edu/~gareth/ISL/) library.
* `python-jupyter`: Extends `base-jupyter` with Python (2 and 3) environments focused on data science, loading common packages such as scikit-learn, pandas, seaborn, etc.
* `pyspark-jupyter`: Extends `python-jupyter` with Apache Spark.

## Installation

To build any of the images, run the build script in that image's folder. The `base-jupyter` image must first be built and available on your system to build any other image. The `pyspark-jupyter` image depends on the `python-jupyter` image.

## Running

Use the `run.sh` script in the corresponding image's folder. Then run the `start-notebook.sh` script, which is in the container root user's path. This provides a URL hash required to access the notebook, such as:

```
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=3e75593fe1a03cf6540c1c4338b33a29e76399bc9fee8c4e
```

If running remotely, replace `localhost` with the appropriate IP address.

#### Options

The `run.sh` can mount two external directories, using the following options:
* `-w|--workdir host_directory_path`: Jupyter's working directory. This becomes `/opt/workdir` in the container.
* `-d|--datadir host_directory_path`: A directory where data is stored. This becomes `/opt/datadir` in the container.
These options are useful for organization's sake, and also in the case when a working or data directory isn't located under your `$HOME` directory.

## Known Issues

* If a browser is already running and attempting to contact the host on port 8888, the notebook server may ask for a password. If this happens, restart the container while ensuring that any existing browser tabs pointing at the server are closed.
* I'd love to include `start-notebook.sh` as the entry command for the images, but this seems to cause the exact same issue as the previous point: Jupyter asks for a password. I have no idea why this is the case. If I can debug this at some point, I'll make the notebook servers automatically start when the container is loaded.
