
# Build base-jupyter first
FROM base-jupyter


USER root



# Install conda dependencies for R kernel
RUN conda install --quiet --yes \
    'numpy' \
    'scipy' \
    'statsmodels' \
    'matplotlib' \
    'scikit-learn' \
    'seaborn' \
    'pandas' && conda clean -tipsy

