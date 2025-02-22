## 22 FEB 2025 Climate Data Extraction

# DATA NO LONGER AVAILABLE & CANNOT ACCESS: 
# - The National Risk Index (NRI) - https://hazards.fema.gov/nri/
# - USDA Climate Adaptation Data - https://www.usda.gov/topics/climate-solutions 
# - Geospatial Energy mapper (GEM) - https://gem.anl.gov/
# - Environmental Justice Screening and Mapping Tool - https://envirodatagov.org/epa-removes-ejscreen-from-its-website/

# CAN ACCESS AT ALTERNATIVE SOURCES
# - HUD Resilient Communities Data (HUD) - accessed on Humanitarian Data Exchange 


# Libraries

required_packages <- c("rnoaa", "nasadata", "dataRetrieval", "httr", "jsonlite", "tidyverse", "raster", "ncdf4")
missing_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}

library(rnoaa)      # NOAA Climate Data - Access climate data from the National Oceanic and Atmospheric Administration (NOAA).
library(nasadata)    # NASA Climate Data - Access climate data from NASA sources.
library(dataRetrieval) # USGS Water & Climate Data - Retrieve water and climate data from the U.S. Geological Survey (USGS).
library(httr)        # API requests - Make HTTP requests to access data from web APIs.
library(jsonlite)    # JSON parsing - Parse and create JSON data, commonly used with web APIs.
library(tidyverse)   # Data manipulation and visualization - Provides a suite of packages for data manipulation, cleaning, and visualization (includes dplyr, ggplot2, etc.).
library(raster)      # Raster data handling - Work with raster data, which is commonly used for spatial data.
library(ncdf4)       # NetCDF data handling - Read and write NetCDF files, a common format for climate and geospatial data.


# Download NOAA Climate Data
# https://github.com/cedardevs/onestop/tree/master/docs#project-overview

noaa_token <- "your_token"  # Get a token from https://www.ncdc.noaa.gov/cdo-web/token
# tONaVKzSSXAUzBFfQPsEfohuUwwtxphw 

#Datasets
# -- GSOY (Global Summary of the Year)
# -- NORMAL_ANN (Annual Normals)

#Data Types
# -- TAVG (Average Temperature)
# -- PRCP (Precipitation)
# -- EVAP (Evapotranspiration)
# -- PSUN (Potential Sunshine)
# -- WESF (Water Equivalent of Snowfall)

# Define parameters
datasets <- c("GSOY", "NORMAL_ANN")  # Yearly datasets
datatypes <- c("TAVG", "PRCP", "EVAP", "PSUN", "WESF")  # Climate variables
start_year <- 1900
end_year <- 2023
location <- "FIPS:WORLD"  # All countries

fetch_noaa_data <- function(dataset, datatype) {
  all_years_data <- list()
  
  for (year in start_year:end_year) {
    cat("Fetching:", dataset, "| Variable:", datatype, "| Year:", year, "\n")  # Progress message
    
    df <- tryCatch(
      ncdc(datasetid = dataset, 
           locationid = location, 
           datatypeid = datatype, 
           startdate = paste0(year, "-01-01"), 
           enddate = paste0(year, "-12-31"), 
           token = noaa_token),
      error = function(e) NULL
    )
    
    if (!is.null(df) && !is.null(df$data)) {
      all_years_data[[as.character(year)]] <- df$data
    }
    
    Sys.sleep(1)
  }
  
  final_df <- bind_rows(all_years_data)
  return(final_df)
}

for (dataset in datasets) {
  for (datatype in datatypes) {
    climate_df <- fetch_noaa_data(dataset, datatype)
    
    if (!is.null(climate_df) && nrow(climate_df) > 0) {
      filename <- paste0("NOAA_", dataset, "_", datatype, "_", start_year, "_", end_year, ".csv")
      write.csv(climate_df, filename, row.names = FALSE)
      cat("Saved:", filename, "\n")
    } else {
      cat("No data found for", dataset, "-", datatype, "\n")
    }
  }
}

cat("All downloads complete!\n")

# Ocean Heat Content - Yearly Difference from Average
base_url <- "https://www.climate.gov/data/Ocean--Yearly--Difference-from-average-Heat-Content--Global/04-full_res_zips/"

file_names <- c(
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--0000-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--1901-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--1904-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--1907-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--1910-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2000-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2001-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2002-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2003-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2004-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2005-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2006-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2007-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2008-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2009-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2010-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2011-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2012-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2013-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2014-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2015-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2016-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2017-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2018-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2019-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2020-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2021-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2022-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Heat-Content--Global--2023-00-00--fullres.zip"
)

for (file_name in file_names) {
  download_url <- paste0(base_url, file_name)
  download.file(download_url, destfile = file_name, mode = "wb")
  cat("Downloaded:", file_name, "\n")
}


# SST - Global, Yearly Difference from Average

base_url <- "https://www.climate.gov/data/Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global/04-full_res_zips/"

file_names <- c(
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--0000-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2000-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2001-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2002-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2003-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2004-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2005-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2006-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2007-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2008-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2009-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2010-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2011-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2012-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2013-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2014-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2015-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2016-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2017-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2018-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2019-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2020-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2021-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2022-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2023-00-00--fullres.zip",
  "Ocean--Yearly--Difference-from-average-Sea-Surface-Temperature--Global--2024-00-00--fullres.zip"
)

for (file_name in file_names) {
  download_url <- paste0(base_url, file_name)
  download.file(download_url, destfile = file_name, mode = "wb")
  cat("Downloaded:", file_name, "\n")
}

# -- CHECK -- #

# U.S. Geological Survey (USGS) 

# U.S. Global Change Research Program (USGCRP)

# National Climate Assessment (NCA) 

# EPA Climate Change

# U.S. Fish and Wildlife Service (USFWS)
