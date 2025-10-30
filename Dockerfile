FROM rocker/r-ver:4.3.2

RUN apt-get update && apt-get install -y \
    pandoc \
    make \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c('knitr','rmarkdown','tinytex'), repos='https://cran.rstudio.com')"
RUN R -e "tinytex::install_tinytex()"

WORKDIR /home/project