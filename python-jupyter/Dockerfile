
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
    'cython' && conda clean -tipsy


# Enable widgets (see: https://github.com/ipython/ipywidgets)
RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix


# Install Python2 and Python2 packages
RUN conda create --yes --name statspython2 python=2.7 \
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
    'cython' && conda clean -tipsy
