## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0

## Return a numeric vector of correlations

corr <- function(directory, threshold = 0) {
    cc <- complete(directory)                              # data frame of number of complete cases
    nobs <- cc$nobs
    goodobs <- cc$id[nobs>threshold]                       #ids of proper locations (having a # of complete cases greater that threshold) 
    
    files_full <- list.files(directory, full.names=TRUE)[goodobs]
    lof <- lapply(files_full, read.csv)
    hm = length(goodobs)
    cr <- vector(length = hm)
    if(hm > 0){
        for (j in 1:hm){
            cr[j] <- cor(lof[[j]]$sulfate, lof[[j]]$nitrate, use="complete.obs")
        }
    }
    return (cr)
} 

#-----

#tests
#cr <- corr("specdata", 150)
#head(cr)
#summary(cr)
#cr <- corr("specdata", 400)
#head(cr)
#summary(cr)
#cr <- corr("specdata", 5000)
#length(cr)