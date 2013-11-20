
username <- Sys.getenv("USER")
localib <- paste("/home/",username,"/Envs/env1/lib64/R/library/",sep="")

install.packages("ctv", repos= "http://cran.rstudio.com/", lib = "/home/ecoop/Envs/env1/lib64/R/library/")
library("ctv")
install.views("Spatial", repos= "http://cran.rstudio.com/", lib = "/home/ecoop/Envs/env1/lib64/R/library/")

