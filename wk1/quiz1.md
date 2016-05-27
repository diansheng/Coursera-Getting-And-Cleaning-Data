Someone has published a pretty neat answer at [http://xmuxiaomo.github.io/2015/07/10/Getting-and-Cleaning-Data-Quiz-1/](http://xmuxiaomo.github.io/2015/07/10/Getting-and-Cleaning-Data-Quiz-1/). It is a pretty good reference.
However, there are still some alternative solutions i think worth taking down.

**Question 1**  

**Alternative solution**
```R
if (!file.exists("data")) {
dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/06hid.csv", method = "curl")

HD <- read.csv("./data/06hid.csv")
colSums(HD['VAL']==24, na.rm=TRUE)
```  
`[1] 53`

---------------
**Question 3** 

If the error message tells you there is no package `xlsx`, run the following command.  
`install.packages('xlsx',repos='http://cran.r-project.org')`   

**Solution (copied from original) **
```R
if (!file.exists("data")) {
dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/gas.xlsx", method = "curl")
library(xlsx)
rowIndex = 18 : 23
colIndex = 7 : 15
dat <- read.xlsx("./data/gas.xlsx", sheetIndex = 1, rowIndex = rowIndex, 
          colIndex = colIndex, header = TRUE)
sum(dat$Zip * dat$Ext, na.rm=T)
```  
`[1] 36534720`
-----------------
**Question 4** 

If the error message tells you there is no package `xlsx`, run the following command.  
`install.packages('XML',repos='http://cran.r-project.org')`   

**Solution (copied from original) **
```R
## Question 4:

# Method 1: remove the letter "s" from "https", and use the "http" instead
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)

sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")

# Method 2: download the XML file first, and then load it into R
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "./data/restaurants.xml", method = "curl")
dateDownloaded <- date()

library(XML)
doc <- xmlTreeParse("./data/restaurants.xml", useInternal = TRUE)
rootNode <- xmlRoot(doc)

sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")
```  
`[1] 127`
-----------------