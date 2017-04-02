
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return a data frame of the form:
## id nobs
## 1  117
## 2  1041
## ...
## where 'id' is the monitor ID number and 'nobs' is the
## number of complete cases

complete <- function(directory, id = 1:332) {
    files_full <- list.files(directory, full.names=TRUE)[id] #select only files in id range
    lof <- lapply(files_full, read.csv)                      # create a list of as many elements (data frames) as the data files
    lcc <- lapply(lof, complete.cases)                       # a list of logical vectors
    dcc <- data.frame()
    for(i in 1:length(lof)){
        dcc <- rbind(dcc, nrow(lof[[i]][lcc[[i]],]))         # only get the complete cases for each
    }
    df <- data.frame(id, nobs = dcc[[1]])
    return (df)
} 

#-----

# tests
#complete("specdata", 1)
#complete("specdata", c(2, 4, 8, 10, 12))
#complete("specdata", 30:25)
#complete("specdata", 3)
