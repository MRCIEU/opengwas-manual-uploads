FROM mrcieu/opengwas-r-r2u:0.1.0


RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('Rhtslib')"
RUN R -e "BiocManager::install('rtracklayer')"
RUN apt-get -y install git
RUN R -e "devtools::install_github('mrcieu/gwasdataimport')"
