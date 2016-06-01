con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(con)
close(con)
for (i in c(10,20,30,100)){
  print(nchar(html[i]))
}