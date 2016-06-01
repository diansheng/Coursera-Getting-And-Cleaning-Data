# download files
if (!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/gdp.csv", method = "curl")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./data/edu.csv", method = "curl")
list.files("./data")
date()

# load data
gdp <- read.csv("./data/gdp.csv", header=TRUE)
edu <- read.csv("./data/edu.csv", header = TRUE)

# clean data
gdp <- gdp[5:194, c(1,2,4,5)]
names(gdp) <- c("CountryCode","Rank","Country","GDP")

merged <- merge(gdp, edu, by="CountryCode")