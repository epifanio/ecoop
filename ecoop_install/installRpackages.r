core <- c("classInt", "DCluster", "deldir", "geoR", "gstat", "maptools",
"RandomFields", "raster", "RColorBrewer", "sp", "spatstat", "rgdal",
"spdep", "splancs","spgrass6", "rgeos","ncdf", "RSAGA")

optional <- c("ade4", "adehabitat", "adehabitatHR", "adehabitatHS", "adehabitatLT", "adehabitatMA", "ads", "akima", "ash", "aspace", "automap", "CircSpatial", "clustTool", "CompRandFld", "constrainedKriging", "cshapes", "diseasemapping", "DSpat", "ecespa", "fields", "FieldSim", "gdistance", "Geneland", "GEOmap", "geomapdata", "geonames", "geoRglm", "geosphere", "GeoXp", "glmmBUGS", "gmaps", "gmt", "Guerry", "hdeco", "intamap", "mapdata", "mapproj", "maps", "MarkedPointProcess", "MBA", "ModelMap", "ncf", "nlme", "pastecs", "PBSmapping", "PBSmodelling", "psgp", "ramps", "RArcInfo", "regress", "RgoogleMaps", "RPyGeo", "RSurvey", "rworldmap", "sgeostat", "shapefiles", "sparr", "spatcounts", "spatgraphs", "spatial", "spatialCovariance", "SpatialExtremes", "spatialkernel", "spatialsegregation", "spBayes", "spcosa", "spgwr", "sphet", "spsurvey", "SQLiteMap", "Stem", "tgp", "trip", "tripack", "tripEstimation", "UScensus2000", "vardiag", "vegan","ctv") 

#non-spatial <- c("RPostgresql","RSQLite","RODBC")

packagelist <- core

username <- Sys.getenv("USER")
localib <- paste("/home/",username,"/Envs/env1/lib64/R/library/",sep="")

for (i in packagelist) {
	install.packages(i, repos= "http://cran.rstudio.com/", lib = localib, dependencies = TRUE) 
	output <- paste("Finished installing",i,sep=" ")
	print(output)
}

packagelist <- optional
for (i in packagelist) {
	install.packages(i, repos= "http://cran.rstudio.com/", lib = localib, dependencies = TRUE) 
	output <- paste("Finished installing",i,sep=" ")
	print(output)
}

q()
