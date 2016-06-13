#### Question 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?

#### Solution
`[1]  125  238  262 `

```R
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
```
-------

#### Question 2
Using the jpeg package read in the following picture of your instructor into R

https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

#### Solution
```
      30%       80% 
-15259150 -10575416 
```

```R

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
```

----

#### Question 3
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table 
http://data.worldbank.org/data-catalog/ed-stats

#### Solution
`[1] 189`  
`[1] St. Kitts and Nevis`

```
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
```

----

#### Question 4

What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

#### Solution

```
             High income: nonOECD    High income: OECD 
          NA             91.91304             32.96667 
  Low income  Lower middle income  Upper middle income 
   133.72973            107.70370             92.13333 
```

```
# Q4
tapply(as.numeric(merged$Rank), merged$Income.Group, mean)
```
------  
#### Question 5

Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group.

How many countries are Lower middle income but among the 38 nations with highest GDP?

#### Solution
```
             High income: nonOECD    High income: OECD 
           0                    4                   18 
  Low income  Lower middle income  Upper middle income 
           0                    5                   11 
```

```
# Q5
# merge$RankGroups <- cut2(merge$Rank, g=5)
# table(merge$RankGroups, merge$`Income Group`)

sorted <- arrange(merged, Rank)
topGDP <- sorted[1:38,]
table(topGDP$`Income.Group`)
```


-------
Someone has also published a pretty neat answer at https://github.com/benjamin-chan/GettingAndCleaningData/blob/master/Quiz2/quiz2.Rmd. It is a pretty good reference.
