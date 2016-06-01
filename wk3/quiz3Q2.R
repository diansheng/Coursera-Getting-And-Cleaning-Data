# download files
if (!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile = "./data/jeff.jpg", method = "curl")
list.files("./data")
date()

# load data
library(jpeg)
data = readJPEG("./data/jeff.jpg", native = TRUE)

quantile(data, probs=c(0.3, 0.8))