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


----

#### Question 4


#### Solution



------  
Someone has also published a pretty neat answer at https://github.com/benjamin-chan/GettingAndCleaningData/blob/master/Quiz2/quiz2.Rmd. It is a pretty good reference.
