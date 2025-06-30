# install_packages.R

# Install base package managers
install.packages("remotes")
install.packages("BiocManager")

# Bioconductor setup
BiocManager::install(version = "3.20", ask = FALSE)
BiocManager::install("KEGGREST", ask = FALSE)  # version "1.46.0"
BiocManager::install("rBLAST", ask = FALSE) # version "1.2.0"

# CRAN packages using remotes with version control
remotes::install_version("tidyverse", version = "2.0.0", dependencies = TRUE)
remotes::install_version("arrow", version = "14.0.0", dependencies = TRUE)
remotes::install_version("data.table", version = "1.14.8", dependencies = TRUE)
remotes::install_version("leaflet", version = "2.1.2", dependencies = TRUE)
remotes::install_version("sp", version = "1.6-1", dependencies = TRUE)
remotes::install_version("magrittr", version = "2.0.3", dependencies = TRUE)
remotes::install_version("shinythemes", version = "1.2.0", dependencies = TRUE)
remotes::install_version("DT", version = "0.28", dependencies = TRUE)
remotes::install_version("shinyjs", version = "2.1.0", dependencies = TRUE)
remotes::install_version("vembedr", version = "0.1.5", dependencies = TRUE)
remotes::install_version("multidplyr", version = "0.1.3", dependencies = TRUE)
remotes::install_version("shinybusy", version = "0.3.1", dependencies = TRUE)
