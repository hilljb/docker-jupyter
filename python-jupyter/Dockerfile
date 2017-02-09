
# Build base-jupyter first
FROM base-jupyter

USER root

# Install Python3 packages
RUN conda install --quiet --yes \
    'numpy' \
    'scipy' \
    'statsmodels' \
    'matplotlib' \
    'scikit-learn' \
    'pymc' \
    'nltk' \
    'seaborn' \
    'bokeh' \
    'pandas' \
    'simplejson' \
    'networkx' \
    'ipywidgets' \
    'cython' && \
    conda remove --yes --force qt pyqt && \
    conda clean -tipsy


# Enable widgets (see: https://github.com/ipython/ipywidgets)
RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix


# Install Python2 and Python2 packages
RUN conda create --yes -p $CONDA_DIR/envs/python2 python=2.7 \
    'numpy' \
    'scipy' \
    'statsmodels' \
    'matplotlib' \
    'scikit-learn' \
    'pymc' \
    'nltk' \
    'seaborn' \
    'bokeh' \
    'pandas' \
    'simplejson' \
    'networkx' \
    'ipywidgets' \
    'cython' && \
    conda remove -n python2 --yes --force qt pyqt && \
    conda clean -tipsy


# Symlink pip for Python2 and Python3 environments
RUN ln -s $CONDA_DIR/envs/python2/bin/pip $CONDA_DIR/bin/pip2 && \
    ln -s $CONDA_DIR/bin/pip $CONDA_DIR/bin/pip3


# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /root/.cache/
RUN MPLBACKEND=Agg $CONDA_DIR/envs/python2/bin/python -c "import matplotlib.pyplot"


# Run matplotlib with inline backend by default
RUN mkdir -p $HOME/.ipython/profile_default/startup
COPY mplimporthook.py $HOME/.ipython/profile_default/startup/


# Register Python2 kernel
RUN pip install kernda --no-cache && \
    $CONDA_DIR/envs/python2/bin/python -m ipykernel install && \
    kernda -o -y /usr/local/share/jupyter/kernels/python2/kernel.json && \
    pip uninstall kernda -y

