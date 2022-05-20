FROM bioconductor/bioconductor_docker:devel

# Based on https://github.com/rocker-org/shiny

MAINTAINER Gibran Hemani "g.hemani@bristol.ac.uk"

# Install dependencies and Download and install shiny server
RUN apt-get update && apt-get install -y \
    sudo \
    libbz2-dev \
    zlib1g-dev \
    libncurses5-dev  \
    libncursesw5-dev \
    liblzma-dev

RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('Rhtslib')"
RUN R -e "BiocManager::install('rtracklayer')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "devtools::install_github('mrcieu/gwasdataimport')"
