## quiz 2 Q1
library(httr)
require(httpuv)

app <- oauth_app("coursera-learner", key = "907e659bfc9b7baf4b8e", secret = "861bfe1b028a21db88fc64a898a5208eca4d537f")
token <- oauth2.0_token(oauth_endpoints("github"), app)
req <- GET("https://api.github.com/users/jtleek/repos", config(token = token))
# Converts http errors to R errors or warnings - these should always be used whenever you're creating requests inside a function, so that the user knows why a request has failed.
stop_for_status(req)
data <- content(req)

for (i in 1:length(data)){
  if (data[[i]]$name == "datasharing"){
    print(data[[i]]$created_at)
    break
  }
}