# Use an official R runtime as a parent image
FROM rocker/shiny:latest
#  "shiny"

# Install system dependencies including those for tidyverse
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git libxml2-dev libmagick++-dev \
    libcurl4-gnutls-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    make \
    pandoc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install Basic Utility R Packages

RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_version('tidyverse', version = '2.0.0', dependencies= T)"
RUN R -e "remotes::install_version('data.table', version = '1.14.8', dependencies= T)"
RUN R -e "remotes::install_version('rBLAST', version = '0.99.2', dependencies= T)"
RUN R -e "remotes::install_version('leaflet', version = '2.1.2', dependencies= T)"
RUN R -e "remotes::install_version('sp', version = '1.6-1', dependencies= T)"
RUN R -e "remotes::install_version('magrittr', version = '2.0.3', dependencies= T)"
RUN R -e "remotes::install_version('KEGGREST', version = '1.38.0', dependencies= T)"
RUN R -e "remotes::install_version('shinythemes', version = '1.2.0', dependencies= T)"
RUN R -e "remotes::install_version('DT', version = '0.28', dependencies= T)"
RUN R -e "remotes::install_version('shinyjs', version = '2.1.0', dependencies= T)"
RUN R -e "remotes::install_version('vembedr', version = '0.1.5', dependencies= T)"
RUN R -e "remotes::install_version('multidplyr', version = '0.1.3', dependencies= T)"
RUN R -e "remotes::install_version('shinybusy', version = '0.3.1', dependencies= T)"

FROM ncbi/blast:2.13.0

RUN rm -rf /srv/shiny-server/* COPY /app/* /srv/shiny-server/

USER shiny

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]