pkgs <- c(
  # Document Building
  "knitr",
  "rmarkdown",

  # Packages needed in the course
  "remotes",
  "RColorBrewer",
  "tableone",
  "xtable"
)

install.packages(pkgs, repos = "https://cran.rstudio.com")
remotes::install_github("EBPI-Biostatistics/biostatUZH")
