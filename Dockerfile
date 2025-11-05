FROM rocker/r-ver:4.3.2

# System dependencies for knitr, rmarkdown, kableExtra, svglite, etc.
RUN apt-get update && apt-get install -y \
    pandoc \
    make \
    curl \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
# fonts / graphics stack
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libharfbuzz-dev \
    libfribidi-dev \
# latex tools
    latexmk \
    texlive-latex-extra \
# tidy up
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# R packages for document building
RUN R -e "install.packages(c('knitr', 'rmarkdown'), repos='https://cran.rstudio.com')"

# Alias for knitting .Rnw files
RUN echo "alias knit='f(){ Rscript -e \"knitr::knit(\\\"\$1\\\")\" && latexmk -pdf \${1%.Rnw}.tex; }; f'" >> /root/.bashrc

WORKDIR /home/project

# Drop into shell
CMD ["bash"]
