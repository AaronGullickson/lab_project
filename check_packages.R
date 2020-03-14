# This script will check for and install if neccesary and packages required for
# the project

if(!require("readr")) {
  install.packages("readr")
  library(readr)
}

if(!require("reshape2")) {
  install.packages("reshape2")
  library(reshape2)
}

if(!require("rmarkdown")) {
  install.packages("rmarkdown")
  library(rmarkdown)
}

if(!require("texreg")) {
  install.packages("devtools")
  library(devtools)
  install_github("leifeld/texreg")
  library(texreg)
}

if(!require("tinytex")) {
  install.packages("tinytex")
  library(tinytex)
}

if(!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}

#install tiny tex if not found
#Mac Users will need to first run the following commands in Terminal
# sudo chown -R `whoami`:admin /usr/local/bin
# ~/Library/TinyTeX/bin/x86_64-darwin/tlmgr path add
if(!tinytex:::is_tinytex()) {
  install_tinytex(force=TRUE)
}


