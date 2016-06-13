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
gdp <- read.csv("./data/gdp.csv", header=TRUE, skip=4, nrows = 190)
edu <- read.csv("./data/edu.csv", header = TRUE)

# clean data
gdp <- gdp[, c(1,2,4,5)]
names(gdp) <- c("CountryCode","Rank","Country","GDP")
# merge by country code
merged <- merge(gdp, edu, by="CountryCode")

# Answer to "How many of the IDs match?"
nrow(merged)

# sort
library(dplyr)
merged$Rank <- as.numeric(merged$Rank)
sorted <- arrange(merged, desc(Rank))
sorted[13, "Country"]

# Q4
tapply(as.numeric(merged$Rank), merged$Income.Group, mean)

# Q5
# merge$RankGroups <- cut2(merge$Rank, g=5)
# table(merge$RankGroups, merge$`Income Group`)

sorted <- arrange(merged, Rank)
topGDP <- sorted[1:38,]
table(topGDP$`Income.Group`)