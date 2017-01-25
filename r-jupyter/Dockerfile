
# Build base-jupyter first
FROM base-jupyter


USER root


# Install additional dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install conda dependencies for R kernel
RUN conda config --add channels r && \
    conda install --quiet --yes \
    'r-base=3.3.1 1' \
    'r-irkernel=0.7*' \
    'r-plyr=1.8*' \
    'r-devtools=1.11*' \
    'r-dplyr=0.4*' \
    'r-ggplot2=2.1*' \
    'r-tidyr=0.5*' \
    'r-shiny=0.13*' \
    'r-rmarkdown=0.9*' \
    'r-forecast=7.1*' \
    'r-stringr=1.0*' \
    'r-rsqlite=1.0*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-crayon=1.3*' \
    'r-randomforest=4.6*' && conda clean -tipsy


# Install the ISLR library
RUN cd /opt && \
    wget https://cran.r-project.org/src/contrib/ISLR_1.0.tar.gz && \
    tar zxvf ISLR_1.0.tar.gz && \
    R -q -e 'install.packages("/opt/ISLR", repos = NULL, type="source")'
