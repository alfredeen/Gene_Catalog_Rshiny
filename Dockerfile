# Use an official R runtime as a parent image
#FROM rocker/shiny:latest
#FROM rocker/shiny:4.5
FROM rocker/shiny:4.4
#  "shiny"

ENV USER=shiny

# Install system dependencies including those for tidyverse
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
    git libxml2-dev libmagick++-dev \
    wget libgomp1 \  
    libssl-dev \     
    make \
    pandoc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#    libcurl4-gnutls-dev \
#    libcurl4-openssl-dev \
# Install Blast
# FROM ncbi/blast:2.13.0

RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.13.0/ncbi-blast-2.13.0+-x64-linux.tar.gz -O /tmp/blast.tar.gz && \
	tar zxvf /tmp/blast.tar.gz -C /opt/ && rm /tmp/blast.tar.gz

ENV PATH="/opt/ncbi-blast-2.13.0+/bin:${PATH}"

# Install Basic Utility R Packages
COPY install_packages.R /tmp/
RUN Rscript /tmp/install_packages.R && rm /tmp/install_packages.R

# Additional packages for logging and diagnosis
RUN R -e "install.packages('log4r')" \
    && R -e "install.packages('readr')" \
    && R -e "install.packages('RcppTOML')"


RUN mkdir /data \
    && mkdir /rlogs \
    && chown -R shiny:shiny /data \
    && chown -R shiny:shiny /rlogs


RUN rm -rf /srv/shiny-server/*
COPY /app/ /srv/shiny-server/
COPY .Renviron.template /srv/shiny-server/.Renviron
COPY shiny-customized.config /etc/shiny-server/shiny-server.conf

WORKDIR /srv/shiny-server/

RUN chown -R shiny:shiny . && \
    chmod ug+x start-script.sh


USER $USER
EXPOSE 3838

CMD ["/usr/bin/shiny-server"]
