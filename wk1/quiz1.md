

#### Question 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

How many properties are worth $1,000,000 or more?

#### Solution
`[1] 53`

```R
if (!file.exists("data")) {
dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/06hid.csv", method = "curl")

HD <- read.csv("./data/06hid.csv")
colSums(HD['VAL']==24, na.rm=TRUE)
```  

---------------

#### Question 2

Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the “tidy data” principles does this variable violate?

#### Solution

Tidy data has one variable per column

------

#### Question 3

Download the Excel spreadsheet on Natural Gas Aquisition Program here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx

Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
`dat`
What is the value of:
`sum(dat$Zip * dat$Ext, na.rm = T)` 
(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

If the error message tells you there is no package `xlsx`, run the following command.  
`install.packages('xlsx',repos='http://cran.r-project.org')`   

#### Solution

`[1] 36534720`  

```R
if (!file.exists("data")) {
dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/gas.xlsx", method = "curl")
library(xlsx)
rowIndex <- 18 : 23
colIndex <- 7 : 15
dat <- read.xlsx("./data/gas.xlsx", sheetIndex = 1, rowIndex = rowIndex, 
          colIndex = colIndex, header = TRUE)
sum(dat$Zip * dat$Ext, na.rm=T)
```  
-----------------
#### Question 4 

Read the XML data on Baltimore restaurants from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

How many restaurants have zipcode 21231?

#### Solution

`[1] 127`  

_Method 1: remove the letter "s" from "https", and use the "http" instead_

```R
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)

sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")
```

_Method 2: download the XML file first, and then load it into R_
```R
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
-----------------
Someone has published a pretty neat answer at http://xmuxiaomo.github.io/2015/07/10/Getting-and-Cleaning-Data-Quiz-1/. It is a pretty good reference.