

FROM debian:testing


# Environmental variables
ENV DEB_NAME testing
ENV DEB_REPO http://cdn-fastly.deb.debian.org 


# As root user (the entire docker build is as root - external mount points are jacked otherwise)
USER root


# Install things required to get off the ground
RUN REPO=http://cdn-fastly.deb.debian.org && \
    echo "deb $DEB_REPO/debian $DEB_NAME main\ndeb $DEB_REPO/debian-security $DEB_NAME/updates main" > /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -yq --no-install-recommends \
       apt-utils \
       wget \
       bzip2 \
       ca-certificates \
       sudo \
       locales \
       git \
       vim \
       jed \
       emacs \
       build-essential \
       python-dev \
       unzip \
       libsm6 \
       pandoc \
       texlive-latex-base \
       texlive-latex-extra \
       texlive-fonts-extra \
       texlive-fonts-recommended \
       texlive-generic-recommended \
       libxrender1 \
       inkscape \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Set locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


# More environmental variables
ENV CONDA_DIR /opt/conda
ENV ROOT_BIN /root/bin
ENV PATH $CONDA_DIR/bin:$ROOT_BIN:$PATH
ENV SHELL /bin/bash
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive


# Install Tini (an init specially made for docker)
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini


# make work and data dirs for external mount points
RUN mkdir /opt/workdir && \
    mkdir /opt/datadir && \
    mkdir /root/.jupyter && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /root/.curlrc


# Install miniconda
RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    conda clean -tipsy


# Temporary workaround for https://github.com/jupyter/docker-stacks/issues/210
# Stick with jpeg 8 to avoid problems with R packages
RUN echo "jpeg 8*" >> /opt/conda/conda-meta/pinned


# Install Jupyter notebook and hub
RUN conda install --quiet --yes \
    'notebook=4.3*' \
    jupyterhub=0.7 \
    && conda clean -tipsy


# Expose port and set working directory
EXPOSE 8888
WORKDIR /opt/workdir


# Add local files as late as possible to avoid cache busting
RUN mkdir -p $ROOT_BIN
COPY resources/start-notebook.sh /usr/local/bin/
COPY resources/start-singleuser.sh /usr/local/bin/
COPY resources/jupyter_notebook_config.py /root/.jupyter/


# Configure container startup
ENTRYPOINT ["tini", "--"]

