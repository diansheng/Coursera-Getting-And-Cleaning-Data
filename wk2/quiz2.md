#### Question 1
Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

#### Solution

`[1] "2013-11-07T13:25:07Z"` 

```R
## quiz 2 Q1
library(httr)
# if httpuv not installed, use `install.packages("httpuv")
require(httpuv)
# replace with your own key and secret here
app <- oauth_app("coursera-learner", key = "907e659bfc9b7baf4b8e", secret = "861bfe1b028a21db88fc64a898a5208eca4d537f")
token <- oauth2.0_token(oauth_endpoints("github"), app)
req <- GET("https://api.github.com/users/jtleek/repos", config(token = token))
# Converts http errors to R errors or warnings - these should always be used whenever you're creating requests inside a function, so that the user knows why a request has failed.
stop_for_status(req)
data <- content(req)

# find repo named "datasharing" and print out "created_at"
for (i in 1:length(data)){
  if (data[[i]]$name == "datasharing"){
    print(data[[i]]$created_at)
    break
  }
}
```
-------

#### Question 2
The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called
`acs`

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

#### Solution

`sqldf("select pwgtp1 from acs where AGEP < 50")` 

```R
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
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")
```
----

#### Question 3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

#### Solution
`sqldf("select distinct AGEP from acs")`

```R
gold <- unique(acs$AGEP)
query1 <- sqldf("select distinct AGEP from acs")
query2 <- sqldf("select AGEP where unique from acs")
query3 <- sqldf("select unique * from acs")
query4 <- sqldf("select unique AGEP from acs")
identical(gold, query1[[1]])
summary(gold)
summary(query1)
```
----

#### Question 4
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

http://biostat.jhsph.edu/~jleek/contact.html

(Hint: the nchar() function in R may be helpful)

#### Solution
```
[1] 45
[1] 31
[1] 7
[1] 25
```

```R
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(con)
close(con)
for (i in c(10,20,30,100)){
  print(nchar(html[i]))
}
```

------  
Someone has also published a pretty neat answer at https://github.com/benjamin-chan/GettingAndCleaningData/blob/master/Quiz2/quiz2.Rmd. It is a pretty good reference.
