# download files
if (!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/pid.csv", method = "curl")
list.files("./data")
date()

# load data
acs <- read.csv("./data/pid.csv")

# Q2
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")

# Q3
gold <- unique(acs$AGEP)
query1 <- sqldf("select distinct AGEP from acs")
query2 <- sqldf("select AGEP where unique from acs")
query3 <- sqldf("select unique * from acs")
query4 <- sqldf("select unique AGEP from acs")
identical(gold, query1[[1]])
summary(gold)
summary(query1)