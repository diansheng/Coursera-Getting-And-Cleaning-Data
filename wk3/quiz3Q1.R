# download files
if (!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/hid.csv", method = "curl")
list.files("./data")
date()

# load data
data <- read.csv("./data/hid.csv")
agricultureLogical <- (data$ACR==3 & data$AGS==6)
head(which(agricultureLogical),3)
