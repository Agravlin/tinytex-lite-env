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
# tidy up
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# R packages for document building
RUN R -e "install.packages(c('knitr', 'rmarkdown', 'tinytex'), repos='https://cran.rstudio.com')"

# Install TinyTeX and configure mirrors
RUN R -e "tinytex::install_tinytex()" \
 && /root/.TinyTeX/bin/x86_64-linux/tlmgr option repository https://mirror.ctan.org/systems/texlive/tlnet \
 && /root/.TinyTeX/bin/x86_64-linux/tlmgr update --self

# A few common LaTeX packages to avoid .sty errors
RUN R -e "tinytex::tlmgr_install(c('booktabs', 'caption', 'threeparttable', 'multirow', 'colortbl', 'xcolor'))"

WORKDIR /home/project

# Drop into shell
CMD ["bash"]
