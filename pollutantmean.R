#get data from remote URL
#dataset_url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
#download.file(dataset_url, "specdata.zip")
#unzip("specdata.zip")

#-----

## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)

#NOTE: do not round the result!

pollutantmean <- function(directory, pollutant = "sulfate", id = 1:332) {
    files_full <- list.files(directory, full.names=TRUE)[id] #select only files in id range
    tmp <- lapply(files_full, read.csv)                      # create a list of as many elements as the data files
    dat <- do.call(rbind, tmp)                               # from a list to a single data frame
    dat <- dat[complete.cases(dat[,pollutant]),]             # clean rows having NA in pollutant column
    mean(dat[,pollutant])                                    # calculate mean of pollutant column
}

#-----

#tests
#source("pollutantmean.R")
#pollutantmean("specdata", "sulfate", 1:10)
#pollutantmean("specdata", "nitrate", 70:72)
#pollutantmean("specdata", "nitrate", 23)


